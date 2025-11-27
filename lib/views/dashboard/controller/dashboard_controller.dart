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

class DashboardController extends GetxController {
  @override
  void onInit() {
    getAreaList();
    getBannerAndOfferProcess();
    getSpecialProducts();
    getPopularProducts();
    _popularProductPagination();
    _offerProductPagination();

    super.onInit();
  }

  _popularProductPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !_isPopularLoading.value &&
          !isLastPage.value) {
        loadMorePopular();
      }
    });

    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      showSearchBox.value = false;
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      showSearchBox.value = true;
    }
  }

  _offerProductPagination() {
    offerScreenScrollController.addListener(() {
      if (offerScreenScrollController.position.pixels >=
              offerScreenScrollController.position.maxScrollExtent &&
          !_specialProductLoading.value &&
          !isLastOfferPage.value) {
        loadMoreOffer();
      }

      offerScreenScrollController.addListener(_onOfferScroll);
    });
  }

  void _onOfferScroll() {
    if (offerScreenScrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      showOfferSearchBox.value = false;
    } else if (offerScreenScrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      showOfferSearchBox.value = true;
    }
  }

  RxBool isExpanded = false.obs;

  final imagePath =
      "${BasicServices.basePath.value}/${BasicServices.productPathLocation.value}/"
          .obs;

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

// Area api section
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
          // Use stored area if available
          final storedId = LocalStorage.selectedAreaId;

          final matchedArea = areaList.firstWhere(
            (area) => area.id == storedId,
            orElse: () => areaList.first,
          );

          selectedArea.value = matchedArea.name;
          selectedAreaId.value = matchedArea.id;

          // Store it back if it was default
          LocalStorage.setSelectedArea(
              name: matchedArea.name, id: matchedArea.id);
        });
  }

  void setSelectedArea(Area area) {
    selectedArea.value = area.name;
    selectedAreaId.value = area.id;
    LocalStorage.setSelectedArea(name: area.name, id: area.id);
  }

  // banner and special offer

  var currentOfferIndex = 0.obs;
  RxList<Product> offerProducts = <Product>[].obs;

  var bannerImageIndex = 0.obs;
  RxList<OfferBanner> bannerImages = <OfferBanner>[].obs;

  final _isBannerOfferLoading = false.obs;
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

// Popular product

  var isLastPage = false.obs;
  // bool get isLastPage => _isLastPage.value;

  Rxn<Product> selectedPopularProduct = Rxn();
  RxList<Product> popularProductsList = <Product>[].obs;

  final _isPopularLoading = false.obs;
  bool get isPopularLoading => _isPopularLoading.value;

  late PopularProductModel _popularProductModel;
  PopularProductModel get popularProductModel => _popularProductModel;

  Future<PopularProductModel?> getPopularProducts({String? termValue}) async {
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
            if (_popularProductModel.data.currentPage >=
                _popularProductModel.data.totalPages) {
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
    if (selectedAreaId.value == 0) {
      popularProductsList.addAll(_popularProductModel.data.product);
    } else {
      popularProductsList.addAll(
        _popularProductModel.data.product.where(
          (product) =>
              product.area.any((area) => area.id == selectedAreaId.value),
        ),
      );
    }
  }

  void loadMorePopular() {
    page.value++;
    getPopularProducts();
  }

  // Special Product
  var isLastOfferPage = false.obs;
  // bool get isLastOfferPage => _isLastOfferPage.value;

  Rxn<Product> selectedSpecialProduct = Rxn();
  RxList<Product> specialProductsList = <Product>[].obs;

  final _specialProductLoading = false.obs;
  bool get specialProductLoading => _specialProductLoading.value;

  late PopularProductModel _specialProduct;
  PopularProductModel get specialProduct => _specialProduct;

  Future<PopularProductModel?> getSpecialProducts({String? termValue}) async {
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
            if (_specialProduct.data.currentPage >=
                _specialProduct.data.totalPages) {
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
    if (selectedAreaId.value == 0) {
      specialProductsList.addAll(_specialProduct.data.product);
    } else {
      specialProductsList.addAll(
        _specialProduct.data.product.where(
          (product) => product.area.any(
            (area) => area.id == selectedAreaId.value,
          ),
        ),
      );
    }
    offerProducts.clear();
    for (int i = 0; i < 5; i++) {
      offerProducts.add(specialProductsList[i]);
    }
  }

  void loadMoreOffer() {
    offerPage.value++;
    getSpecialProducts();
  }
}
