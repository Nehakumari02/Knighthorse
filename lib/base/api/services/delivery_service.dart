import 'package:get/get.dart';

import '../../../views/auth section/auth_model/delivery_settings_model.dart';
import '../endpoint/api_endpoint.dart';
import '../method/request_process.dart';

class DeliveryServices {
  static var bagStatus = 0.obs;
  static var freedeliveryStatus = 0.obs;
  static var bagPrice = 0.obs;
  static var amountSpend = 0.obs;
  static var deliveryCount = 0.obs;


  static final _isLoading = false.obs;
  static bool get isLoading => _isLoading.value;
  static late DeliverySettingsModel _deliverySettingsModel;
  static DeliverySettingsModel get deliverySettingsModel => _deliverySettingsModel;

  static Future<DeliverySettingsModel?> getDeliverySettingsInfo() async {
    return RequestProcess().request<DeliverySettingsModel>(
        fromJson: DeliverySettingsModel.fromJson,
        apiEndpoint: ApiEndpoint.deliverySettings,
        isLoading: _isLoading,
        showSuccessMessage: false,
        onSuccess: (value) {
          _deliverySettingsModel = value!;
          freedeliveryStatus.value = _deliverySettingsModel.data.delivery.freeDeliveryStatus;
          bagStatus.value = _deliverySettingsModel.data.delivery.bagStatus;
          bagPrice.value = _deliverySettingsModel.data.delivery.bagPrice;
          amountSpend.value = _deliverySettingsModel.data.delivery.amountSpend;
          deliveryCount.value = _deliverySettingsModel.data.delivery.deliveryCount;
        }
        );
  }
}
