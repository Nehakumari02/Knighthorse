import 'package:knighthorse/views/category/controller/category_controller.dart';
import 'package:knighthorse/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../base/api/endpoint/api_endpoint.dart';
import '../../../base/api/method/request_process.dart';
import '../../dashboard/model/popular_product_model.dart';

class ProductListController extends GetxController {
  final searchController = TextEditingController();
  var showSearchBox = true.obs;

  var data = Get.find<CategoryController>().selelctedSubCategory.value;
  RxString categoryName = "".obs;

  final page = 1.obs;
  final limit = 7.obs;
  final currentPage = 0.obs;
  final totalPage = 0.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    categoryName.value = data!.data.name;
    getAllProductsProcess();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !_isProductLoading.value &&
          !isLastPage.value) {
        loadMore();
      }
    });
    scrollController.addListener(_onScroll);

    super.onInit();
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

  Rxn<Product> selectedProduct = Rxn<Product>();
  RxList<Product> productsList = <Product>[].obs;

  var isLastPage = false.obs;

  var _isProductLoading = false.obs;
  bool get isProductLoading => _isProductLoading.value;

  late PopularProductModel _productModel;
  PopularProductModel get productModel => _productModel;

  Future<PopularProductModel?> getAllProductsProcess(
      {String? termValue}) async {
    debugPrint(
        "+++++++++++++++++++++++++++++++++++ Calling Sub cat products ++++++++++++++++++++++++++");
    Map<String, dynamic> inputBody = {
      "sub_category_id": data!.id,
      "page": page.value,
      "limit": limit.value,
      "sort_direction": "desc",
      "term": termValue
    };
    return RequestProcess().request(
        fromJson: PopularProductModel.fromJson,
        apiEndpoint: ApiEndpoint.subCategoryProductList,
        body: inputBody,
        isBasic: true,
        method: HttpMethod.POST,
        isLoading: _isProductLoading,
        onSuccess: (value) {
          _productModel = value!;
          _setProductData();
          debugPrint(
              "-------------------------- data set --------------------- ${productsList.length}");
          debugPrint(
              "-------------------------- data lenght --------------------- ${_productModel.data.totalProducts}");
          debugPrint(
              "-------------------------- total page --------------------- ${_productModel.data.totalPages}");
          debugPrint(
              "-------------------------- current page --------------------- ${_productModel.data.currentPage}");

          if (termValue == null || termValue.isEmpty) {
            if (_productModel.data.currentPage >=
                _productModel.data.totalPages) {
              isLastPage.value = true;
            }
          } else {
            if (_productModel.data.currentPage == 1) {
              isLastPage.value = true;
            }
          }
        });
  }

  _setProductData() {
    currentPage.value = _productModel.data.currentPage;
    totalPage.value = _productModel.data.totalPages;

    if (page.value == 1) productsList.clear();
    if (Get.find<DashboardController>().selectedAreaId.value == 0) {
      productsList.addAll(_productModel.data.product);
    } else {
      productsList.addAll(
        _productModel.data.product.where(
          (product) => product.area.any((area) =>
              area.id == Get.find<DashboardController>().selectedAreaId.value),
        ),
      );
    }
    debugPrint("++++++++++++++++ ${productsList.length}");
    debugPrint("++++++++++++++++ ${page}");
    // debugPrint("++++++++++++++++ ${}");
    isLastPage.value = currentPage.value >= totalPage.value;
  }

  void loadMore() {
    page.value++;
    getAllProductsProcess();
  }
}
