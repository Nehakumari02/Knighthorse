import 'package:knighthorse/base/api/method/request_process.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../base/api/endpoint/api_endpoint.dart';
import '../../../base/api/services/basic_services.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../model/product_search_model.dart';

class SearchFieldController extends GetxController {
  final searchController = TextEditingController();
  var imagePath =
      "${BasicServices.basePath.value}/${BasicServices.productPathLocation.value}/";

  var _isSearchLoading = false.obs;
  bool get isSearchLoading => _isSearchLoading.value;

  late ProductSearchModel _productSearchModel;
  ProductSearchModel get productSearchModel => _productSearchModel;

  Future<ProductSearchModel?> getProductResult(String productName) async {
    Map<String, dynamic> inputBody = {"product_name": productName};

    return RequestProcess().request(
        fromJson: ProductSearchModel.fromJson,
        apiEndpoint: ApiEndpoint.searchProduct,
        isLoading: _isSearchLoading,
        method: HttpMethod.POST,
        body: inputBody,
        onSuccess: (value) {
          _productSearchModel = value!;
          searchList.clear();
          // searchList.addAll(_productSearchModel.data.product);

          searchList.addAll(
            _productSearchModel.data.product.where(
              (product) => product.area.any((area) =>
                  area.id ==
                  Get.find<DashboardController>().selectedAreaId.value),
            ),
          );
        });
  }

  RxList<Product> searchList = <Product>[].obs;
}
