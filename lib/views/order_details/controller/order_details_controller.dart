import 'package:knighthorse/base/api/endpoint/api_endpoint.dart';
import 'package:knighthorse/base/api/services/shipment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/api/method/request_process.dart';
import '../../../base/api/services/basic_services.dart';
import '../../orders/controller/orders_controller.dart';
import '../model/order_details_model.dart';

class OrderDetailsController extends GetxController {
  @override
  void onInit() {
    getOrderDetailsProcess();
    super.onInit();
  }

// usable

  var trackingNumber = "".obs;
  var deliveryDate = "".obs;
  var deliveryTime = "".obs;
  var shippingMethod = "".obs;

  var deliveryCharge = "".obs;
  var reusableBag = "".obs;
  var currencySymbol = "".obs;
  var subTotal = "".obs;
  var totalAmount = "".obs;

  var paymentGatewayCharge = "".obs;
  var paymentMethod = "".obs;
  var transactionID = "".obs;
  var orderStatus = 0.obs;
  var orderDate = "".obs;
  var imagePath =
      "${BasicServices.basePath}/${BasicServices.productPathLocation}".obs;

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final orderNoteController = TextEditingController();

  RxList<Product> orderItemsList = <Product>[].obs;

  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  late OrderDetailsModel _orderDetailsModel;
  OrderDetailsModel get orderDetailsModel => _orderDetailsModel;
  Future<OrderDetailsModel?> getOrderDetailsProcess() async {
    Map<String, dynamic> inputBody = {
      "uuid": Get.find<OrdersController>().orderId.value
    };
    return RequestProcess().request(
        fromJson: OrderDetailsModel.fromJson,
        apiEndpoint: ApiEndpoint.orderDetails,
        body: inputBody,
        method: HttpMethod.POST,
        isLoading: _isLoading,
        onSuccess: (value) {
          _orderDetailsModel = value!;
          _setOrderData();
          _setCartData();
          _setDeliveryData();
          _setShipmentData();
          _setPaymentData();
          currencySymbol.value = _orderDetailsModel.data.currencySymbol;
        });
  }

  _setOrderData() {
    orderItemsList.clear();
    orderItemsList.addAll(_orderDetailsModel.data.bookingData.products);
  }

  _setDeliveryData() {
    var data = _orderDetailsModel.data.bookingData.deliveryInfo;
    phoneController.text = data.phone;
    emailController.text = data.email;
    addressController.text = data.address;
    orderNoteController.text = data.notes;
    reusableBag.value = data.reusableBag;
  }

  _setCartData() {
    var data = _orderDetailsModel.data.bookingData.userCart;
    subTotal.value = data.subTotal;
    totalAmount.value = data.total;
    deliveryCharge.value = data.deliveryCharge;
  }

  _setShipmentData() {
    var data = _orderDetailsModel.data.transaction.orderShipment.first;
    trackingNumber.value = data.trackingNumber;
    deliveryDate.value = DateFormat("yyyy-MM-dd").format(data.deliveryDate);
    deliveryTime.value = "${data.startTime}-${data.endTime}";
    shippingMethod.value = ShipmentServices.shipmentList
        .where((e) => e.id == data.shipmentId.toInt())
        .first
        .name;
  }

  _setPaymentData() {
    var data = _orderDetailsModel.data.transaction;
    transactionID.value = data.trxId;
    orderDate.value = data.createdAt;
    orderStatus.value = data.status;
    paymentMethod.value = data.paymentMethod;
    paymentGatewayCharge.value =
        double.parse(data.paymentGatewayCharge).toStringAsFixed(2);
  }
}
