import 'package:knighthorse/base/api/endpoint/api_endpoint.dart';
import 'package:knighthorse/base/api/method/request_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../base/api/services/basic_services.dart';
import '../../../base/api/services/delivery_service.dart';
import '../../../base/utils/local_storage.dart';
import '../model/area_model.dart';
import '../model/banner_offer_model.dart';
import '../model/popular_product_model.dart';
import '../../update_profile/model/profile_info_model.dart';
import '../../all_product_list/screen/all_product_list_screen.dart';
// Change the old import to this:
import '../model/featured_category_model.dart';
class DashboardController extends GetxController {

  // Store the Logged In User Type
  var fetchedUserType = "".obs;
  // Inside DashboardController class
  var isLastAllProductPage = false.obs; // Prevents API calls when end of list reached
  final _isLoadMoreLoading = false.obs; // Controls the bottom spinner during scroll


  @override
  void onInit() {
    getAreaList();
    getBannerAndOfferProcess();
    fetchFeaturedCategories();

    // CHAINING: Profile FIRST -> Then Products
    // This ensures we know if user is 'retailer' or 'wholesaler' before fetching products
    _fetchUserTypeAndLoadProducts();

    _popularProductPagination();
    _offerProductPagination();
    super.onInit();
  }
  void loadMoreAllProducts() {
    // ✅ isAllProductLoading is a bool getter, so no .value needed
    if (isAllProductLoading || isLastAllProductPage.value) return;

    debugPrint("🔄 Loading Page: ${page.value + 1}");
    page.value++;
    getAllProducts();
  }


// ==========================================
  // 👇 FEATURED CATEGORY SECTION (UPDATED)
  // ==========================================

  // Public list (connected to UI)
  var featuredCategories = <FeaturedCategory>[].obs;

  // Private list (stores original data from API)
  List<FeaturedCategory> _rawFeaturedList = [];

  var isFeaturedLoading = true.obs;

  void fetchFeaturedCategories() async {
    isFeaturedLoading.value = true;
    print("🚀 [Featured] Starting API Call...");

    await RequestProcess().request<FeaturedCategoryModel>(
        apiEndpoint: ApiEndpoint.featuredCategories,
        fromJson: FeaturedCategoryModel.fromJson,
        method: HttpMethod.GET,
        isLoading: false.obs,
        isBasic: true,
        onSuccess: (response) {
          if (response != null && response.data?.categories != null) {
            var list = response.data!.categories!;
            print("📦 [Featured] API Returned: ${list.length} items");

            // 1. Store data in the RAW list first
            _rawFeaturedList = list;

            // 2. Try to filter immediately (if User Type is already loaded)
            _filterFeaturedCategories();
          }
        },
        onError: (error) {
          print("❌ [Featured] API Error: $error");
        }
    );

    isFeaturedLoading.value = false;
  }

  // 👇 HELPER: Filters the raw list based on User Type
  void _filterFeaturedCategories() {
    // If we don't know the user type yet, or have no data, stop.
    if (fetchedUserType.value.isEmpty || _rawFeaturedList.isEmpty) {
      featuredCategories.clear();
      return;
    }

    String myType = fetchedUserType.value.toLowerCase().trim();
    print("🔍 [Featured] Filtering for User Type: '$myType'");

    var filtered = _rawFeaturedList.where((item) {
      // Assuming your model has 'userType' or 'user_type'
      // If it's different, change 'item.userType' to the correct variable name
      String catType = item.user_type?.toLowerCase().trim() ?? "";
      return catType == myType;
    }).toList();

    // Update the UI list
    featuredCategories.assignAll(filtered);
    print("✅ [Featured] Filtered Result: ${featuredCategories.length} items");
  }



  void _fetchUserTypeAndLoadProducts() async {
    await RequestProcess().request(
      apiEndpoint: ApiEndpoint.profileInfo,
      fromJson: ProfileInfoModel.fromJson,
      isLoading: false.obs,
      onSuccess: (response) {
        if (response != null) {
          // 1. Set the Type
          fetchedUserType.value = response.data.userInfo.user_type ?? "";
          debugPrint("✅ Logged In User Type: ${fetchedUserType.value}");

          // 2. Load Products (Now that we have the type)
          _filterFeaturedCategories();
          getSpecialProducts();
          getPopularProducts();
          getAllProducts();
        }
      },
    );
  }

  // ==========================================
  // HELPER: CENTRALIZED FILTER LOGIC
  // ==========================================
  List<Product> _filterByAreaAndUserType(List<Product> rawList) {
    if (fetchedUserType.value.isEmpty) return [];

    String myType = fetchedUserType.value.toLowerCase().trim();
    int areaId = selectedAreaId.value;

    return rawList.where((product) {
      // 1. Check User Type Match
      String pType = product.userType?.toLowerCase().trim() ?? "";
      bool typeMatch = (pType == myType);

      // 2. Check Area Match (If an area is selected)
      bool areaMatch = true;
      if (areaId != 0) {
        areaMatch = product.area.any((area) => area.id == areaId);
      }

      // Return true only if BOTH match
      return typeMatch && areaMatch;
    }).toList();
  }

  // ==========================================
  // SCROLL & PAGINATION
  // ==========================================
  _popularProductPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent &&
          !_isPopularLoading.value && !isLastPage.value) {
        loadMorePopular();
      }
    });
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      showSearchBox.value = false;
    } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
      showSearchBox.value = true;
    }
  }

  _offerProductPagination() {
    offerScreenScrollController.addListener(() {
      if (offerScreenScrollController.position.pixels >= offerScreenScrollController.position.maxScrollExtent &&
          !_specialProductLoading.value && !isLastOfferPage.value) {
        loadMoreOffer();
      }
      offerScreenScrollController.addListener(_onOfferScroll);
    });
  }

  void _onOfferScroll() {
    if (offerScreenScrollController.position.userScrollDirection == ScrollDirection.reverse) {
      showOfferSearchBox.value = false;
    } else if (offerScreenScrollController.position.userScrollDirection == ScrollDirection.forward) {
      showOfferSearchBox.value = true;
    }
  }

  // ==========================================
  // VARIABLES
  // ==========================================
  RxBool isExpanded = false.obs;
  final imagePath = "${BasicServices.basePath.value}/${BasicServices.productPathLocation.value}/".obs;
  final page = 1.obs;
  final limit = 10.obs;
  final ScrollController scrollController = ScrollController();
  final searchController = TextEditingController();
  var showSearchBox = true.obs;

  final offerPage = 1.obs;
  final offerProductLimit = 10.obs;
  final ScrollController offerScreenScrollController = ScrollController();
  final specialSearchController = TextEditingController();
  var showOfferSearchBox = true.obs;
  var offerSpendAmount = DeliveryServices.amountSpend.value;
  var freeDeliveryAmount = DeliveryServices.deliveryCount.value;

  // ==========================================
  // AREA SECTION
  // ==========================================
  var selectedArea = "All Areas".obs;
  var selectedAreaId = 0.obs;
  RxList<Area> areaList = <Area>[].obs;
  final _isAreaLoading = false.obs;
  bool get isAreaLoading => _isAreaLoading.value;
  late AreaModel _area;
  AreaModel get area => _area;

  Future<AreaModel?> getAreaList() async {
    return RequestProcess().request<AreaModel>(
        fromJson: AreaModel.fromJson,
        apiEndpoint: ApiEndpoint.area,
        isLoading: _isAreaLoading,
        isBasic: true,
        onSuccess: (value) {
          _area = value!;
          areaList.clear();
          areaList.addAll(_area.data.area);
          final storedId = LocalStorage.selectedAreaId;
          final matchedArea = areaList.firstWhere(
                (area) => area.id == storedId,
            orElse: () => areaList.first,
          );
          selectedArea.value = matchedArea.name;
          selectedAreaId.value = matchedArea.id;
          LocalStorage.setSelectedArea(name: matchedArea.name, id: matchedArea.id);

          // Re-fetch products if area changes automatically
          if(fetchedUserType.value.isNotEmpty) {
            _setPopulardata();
            // You might want to call _setAllProductsData here too if you store the model
          }
        });
  }

  void setSelectedArea(Area area) {
    selectedArea.value = area.name;
    selectedAreaId.value = area.id;
    LocalStorage.setSelectedArea(name: area.name, id: area.id);

    // Refresh lists when area is manually changed
    page.value = 1;
    offerPage.value = 1;
    if(fetchedUserType.value.isNotEmpty) {
      getPopularProducts();
      getSpecialProducts();
      getAllProducts();
    }
  }

  // ==========================================
  // BANNER SECTION
  // ==========================================
  var currentOfferIndex = 0.obs;
  RxList<Product> offerProducts = <Product>[].obs;
  var bannerImageIndex = 0.obs;
  RxList<OfferBanner> bannerImages = <OfferBanner>[].obs;
  final _isBannerOfferLoading = true.obs;
  bool get isBannerOfferLoading => _isBannerOfferLoading.value;
  late BannerOfferModel _bannerOfferModel;
  BannerOfferModel get bannerOfferModel => _bannerOfferModel;

  Future<BannerOfferModel?> getBannerAndOfferProcess() async {
    return RequestProcess().request(
        fromJson: BannerOfferModel.fromJson,
        apiEndpoint: ApiEndpoint.bannerOffer,
        isLoading: _isBannerOfferLoading,
        isBasic: true,
        onSuccess: (value) {
          _bannerOfferModel = value!;
          _setBannerOfferData();
        });
  }

  _setBannerOfferData() {
    bannerImages.clear();
    bannerImages.addAll(_bannerOfferModel.data.banner);
  }

  // ==========================================
  // POPULAR PRODUCT SECTION
  // ==========================================
  var isLastPage = false.obs;
  Rxn<Product> selectedPopularProduct = Rxn();
  RxList<Product> popularProductsList = <Product>[].obs;
  final _isPopularLoading = true.obs;
  bool get isPopularLoading => _isPopularLoading.value;
  late PopularProductModel _popularProductModel;
  PopularProductModel get popularProductModel => _popularProductModel;

  Future<PopularProductModel?> getPopularProducts({String? termValue}) async {
    if(fetchedUserType.value.isEmpty) return null;

    Map<String, dynamic> inputBody = {
      "page": page.value,
      "limit": limit.value,
      "sort_direction": "desc",
      if (termValue != null && termValue.isNotEmpty) "term": termValue
    };
    return RequestProcess().request(
        fromJson: PopularProductModel.fromJson,
        apiEndpoint: ApiEndpoint.popularProduct,
        isLoading: _isPopularLoading,
        body: inputBody,
        isBasic: true,
        method: HttpMethod.POST,
        onSuccess: (value) {
          _popularProductModel = value!;
          _setPopulardata();
          if (termValue == null || termValue.isEmpty) {
            if (_popularProductModel.data.currentPage >= _popularProductModel.data.totalPages) {
              isLastPage.value = true;
            }
          } else {
            if (_popularProductModel.data.currentPage == 1) {
              isLastPage.value = true;
            }
          }
        });
  }

  _setPopulardata() {
    if (page.value == 1) popularProductsList.clear();

    // Use Helper Method
    List<Product> filtered = _filterByAreaAndUserType(_popularProductModel.data.product);
    popularProductsList.addAll(filtered);

    print("✅ Popular List Count: ${popularProductsList.length}");
  }

  void loadMorePopular() {
    page.value++;
    getPopularProducts();
  }

  // ==========================================
  // ALL PRODUCTS SECTION
  // ==========================================
  RxList<Product> allProductList = <Product>[].obs;
  final _isAllProductLoading = true.obs;
  bool get isAllProductLoading => _isAllProductLoading.value;

  // 👇 ADD THESE VARIABLES FOR FILTERING
  var filteredProductList = <Product>[].obs;
  var minFilterPrice = 0.0.obs;
  var maxFilterPrice = 10000.0.obs;
  var currentRangeValues = const RangeValues(0, 10000).obs;

  Future<void> getAllProducts() async {
    if (fetchedUserType.value.isEmpty) return;

    bool isFirstPage = (page.value == 1);

    // Set loading states
    if (isFirstPage) {
      _isAllProductLoading.value = true;
    } else {
      _isLoadMoreLoading.value = true;
    }

    Map<String, dynamic> inputBody = {
      "page": page.value,
      "limit": 10,
      "sort_direction": "desc",
      // Optional: send user_type to server anyway to encourage backend fix
      "user_type": fetchedUserType.value.toLowerCase().trim(),
    };

    await RequestProcess().request<PopularProductModel>(
        apiEndpoint: ApiEndpoint.allProductList,
        fromJson: PopularProductModel.fromJson,
        method: HttpMethod.POST,
        body: inputBody,
        isBasic: true,
        isLoading: false.obs,
        onSuccess: (response) {
          if (response != null) {
            if (isFirstPage) allProductList.clear();

            // 1. STRICTURE FILTER: Manual separation because server is not doing it
            String myType = fetchedUserType.value.toLowerCase().trim();
            List<Product> strictlyFiltered = response.data.product.where((product) {
              String pType = product.userType?.toLowerCase().trim() ?? "";
              return pType == myType;
            }).toList();

            // 2. Add only the correct products to the list
            allProductList.addAll(strictlyFiltered);

            // 3. Pagination Check (Check total response, not filtered list)
            if (response.data.product.length < 10) {
              isLastAllProductPage.value = true;
            }

            // 4. AUTO-FETCH: If all 10 items were filtered out, get next page automatically
            if (strictlyFiltered.isEmpty && !isLastAllProductPage.value) {
              page.value++;
              getAllProducts();
            }

            initializeFilter(); // Sync the price filter list
          }
        });

    _isAllProductLoading.value = false;
    _isLoadMoreLoading.value = false;
  }

  _setAllProductsData(PopularProductModel model) {
    allProductList.clear();

    // Use Helper Method
    List<Product> filtered = _filterByAreaAndUserType(model.data.product);
    allProductList.addAll(filtered);

    print("✅ All Product List Count: ${allProductList.length}");
    // 👇 ADD THIS LINE
    initializeFilter();
  }
  // 👇 PASTE THESE NEW FUNCTIONS HERE
  void initializeFilter() {
    if (allProductList.isEmpty) {
      filteredProductList.clear();
      return;
    }

    // Find the highest price in the list
    double maxPrice = 0.0;
    for (var item in allProductList) {
      double p = double.tryParse(item.price) ?? 0.0;
      if (p > maxPrice) maxPrice = p;
    }

    // Set max limit (add a buffer)
    maxFilterPrice.value = (maxPrice > 0) ? maxPrice + 100 : 10000;
    currentRangeValues.value = RangeValues(0, maxFilterPrice.value);

    // Initial State: Show Everything
    filteredProductList.assignAll(allProductList);
  }

  void applyPriceFilter(RangeValues values) {
    currentRangeValues.value = values;

    var temp = allProductList.where((item) {
      double price = double.tryParse(item.price) ?? 0.0;
      return price >= values.start && price <= values.end;
    }).toList();

    filteredProductList.assignAll(temp);
  }

  // ==========================================
  // SPECIAL/OFFER PRODUCT SECTION
  // ==========================================
  var isLastOfferPage = false.obs;
  Rxn<Product> selectedSpecialProduct = Rxn();
  RxList<Product> specialProductsList = <Product>[].obs;
  final _specialProductLoading = false.obs;
  bool get specialProductLoading => _specialProductLoading.value;
  late PopularProductModel _specialProduct;
  PopularProductModel get specialProduct => _specialProduct;

  Future<PopularProductModel?> getSpecialProducts({String? termValue}) async {
    if(fetchedUserType.value.isEmpty) return null;

    Map<String, dynamic> inputBody = {
      "page": offerPage.value,
      "limit": offerProductLimit.value,
      "sort_direction": "desc",
      "term": termValue
    };
    return RequestProcess().request(
        fromJson: PopularProductModel.fromJson,
        apiEndpoint: ApiEndpoint.specialOffer,
        method: HttpMethod.POST,
        body: inputBody,
        isBasic: true,
        isLoading: _specialProductLoading,
        onSuccess: (value) {
          _specialProduct = value!;
          _setOfferProducts();
          if (termValue == null || termValue.isEmpty) {
            if (_specialProduct.data.currentPage >= _specialProduct.data.totalPages) {
              isLastOfferPage.value = true;
            }
          } else {
            if (_specialProduct.data.currentPage == 1) {
              isLastOfferPage.value = true;
            }
          }
        });
  }

  _setOfferProducts() {
    if (offerPage.value == 1) specialProductsList.clear();

    // Use Helper Method
    List<Product> filtered = _filterByAreaAndUserType(_specialProduct.data.product);
    specialProductsList.addAll(filtered);

    // Update the 'top 5' list for sliders/widgets
    offerProducts.clear();
    for (int i = 0; i < 5; i++) {
      if(i < specialProductsList.length) {
        offerProducts.add(specialProductsList[i]);
      }
    }
    print("✅ Special List Count: ${specialProductsList.length}");
  }

  void loadMoreOffer() {
    offerPage.value++;
    getSpecialProducts();
  }
}