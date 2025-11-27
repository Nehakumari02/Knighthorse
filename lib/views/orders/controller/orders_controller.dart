import 'package:knighthorse/base/api/method/request_process.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/api/endpoint/api_endpoint.dart';
import '../model/order_list_model.dart';

class OrdersController extends GetxController {

  @override
  void onInit() {
    getOrderListProcess();
    super.onInit();
  }

  final orderId = "".obs;

  RxList<OrderList> orderList = <OrderList>[].obs;
  
  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late OrderListModel _orderListModel;
  OrderListModel get orderListModel => _orderListModel;

  Future<OrderListModel?> getOrderListProcess()async{
    return RequestProcess().request(
      fromJson: OrderListModel.fromJson, 
      apiEndpoint: ApiEndpoint.orderList, 
      isLoading: _isLoading, 
      onSuccess: (value){
        _orderListModel = value!;
        orderList.clear();
        orderList.addAll(_orderListModel.data.orderList);
        debugPrint("add orders ${orderList.length}");
      });
  }

}
