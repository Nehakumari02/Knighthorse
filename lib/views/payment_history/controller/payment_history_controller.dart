import 'package:knighthorse/base/api/method/request_process.dart';
import 'package:get/get.dart';

import '../../../base/api/endpoint/api_endpoint.dart';
import '../model/payment_history_model.dart';

class PaymentHistoryController extends GetxController {
  @override
  void onInit() {
    getPaymentHistoryProcess();
    super.onInit();
  }

  RxList<PaymentHistory> paymentHistoryList = <PaymentHistory>[].obs;
  RxInt expandedIndex = (-1).obs;

  var _isPaymentHistoryLoading = false.obs;
  bool get isPaymentHistoryLoading => _isPaymentHistoryLoading.value;
  late PaymentHistoryModel _paymentHistoryModel;
  PaymentHistoryModel get paymentHistoryModel => _paymentHistoryModel;

  Future<PaymentHistoryModel?> getPaymentHistoryProcess() async {
    return RequestProcess().request(
        fromJson: PaymentHistoryModel.fromJson,
        apiEndpoint: ApiEndpoint.paymentHistory,
        isLoading: _isPaymentHistoryLoading,
        onSuccess: (value) {
          _paymentHistoryModel = value!;
          paymentHistoryList.clear();
          paymentHistoryList.addAll(_paymentHistoryModel.data.paymentHistory);
        });
  }
}
