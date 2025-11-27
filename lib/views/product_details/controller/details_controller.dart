import 'package:knighthorse/base/api/endpoint/api_endpoint.dart';
import 'package:knighthorse/base/api/method/request_process.dart';
import 'package:knighthorse/views/dashboard/controller/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../../base/api/services/basic_services.dart';
import '../../../base/utils/local_storage.dart';
import '../../cart/controller/cart_controller.dart';
import '../../dashboard/model/popular_product_model.dart';
import '../model/product_details_model.dart';

class DetailsController extends GetxController {
  Rxn<Product> selectedProduct = Rxn();
  var currentImage = "".obs;
  late int selectedProductId;
  CartController? cartController = Get.put(CartController());
  RxInt get quantity => cartController?.itemQuantity ?? 1.obs;

  final imagePath =
      "${BasicServices.basePath.value}/${BasicServices.productPathLocation.value}/";

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    selectedProductId = args['productId'];
    getProductDetails(selectedProductId);
  }

  var _hasAdded = false.obs;
  bool get hasAdded => _hasAdded.value;

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  RxList<Product> similarProduct = <Product>[].obs;

  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late ProductDetailsModel _detailsModel;
  ProductDetailsModel get detailsModel => _detailsModel;

  Future<ProductDetailsModel?> getProductDetails(int id) async {
    Map<String, dynamic> inputBody = {"product_id": id};

    return RequestProcess().request(
        fromJson: ProductDetailsModel.fromJson,
        apiEndpoint: ApiEndpoint.productDetails,
        isLoading: _isLoading,
        body: inputBody,
        method: HttpMethod.POST,
        onSuccess: (value) {
          _detailsModel = value!;
          selectedProduct.value = _detailsModel.data.product;
          currentImage.value = selectedProduct.value!.image;
          if (LocalStorage.isLoggedIn) {
            _hasAdded.value = cartController!.cartItems
                .any((item) => item.id == selectedProduct.value!.id.toString());
          }
          ;
          _setItems();
        });
  }
  void changeImage(String imgName) {
    currentImage.value = imgName;
  }

  _setItems() {
    similarProduct.clear();
    if (Get.find<DashboardController>().selectedAreaId.value == 0) {
      similarProduct
          .addAll(List.from(_detailsModel.data.similarProducts)..shuffle());
    } else {
      similarProduct.addAll(
        _detailsModel.data.similarProducts
            .where((product) => product.area.any(
                  (area) =>
                      area.id ==
                      Get.find<DashboardController>().selectedAreaId.value,
                ))
            .toList()
          ..shuffle(),
      );
    }
  }
}
