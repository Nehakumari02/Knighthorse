import 'package:get/get.dart';

import '../../../views/auth section/auth_model/shipment_settings_model.dart';
import '../endpoint/api_endpoint.dart';
import '../method/request_process.dart';

class ShipmentServices {
  static final RxList<Shipment> shipmentList = <Shipment>[].obs;

  static final _isLoading = false.obs;
  static bool get isLoading => _isLoading.value;
  static late ShipmentSettingsModel _shipmentSettingsModel;
  static ShipmentSettingsModel get shipmentSettingsModel =>
      _shipmentSettingsModel;

  static Future<ShipmentSettingsModel?> getShipmentSettingsInfo() async {
    return RequestProcess().request<ShipmentSettingsModel>(
        fromJson: ShipmentSettingsModel.fromJson,
        apiEndpoint: ApiEndpoint.shipmentSettings,
        isLoading: _isLoading,
        showSuccessMessage: false,
        onSuccess: (value) {
          _shipmentSettingsModel = value!;
          shipmentList.addAll(_shipmentSettingsModel.data.shipment);
        });
  }
}
