class ShipmentSettingsModel {
    Message message;
    Data data;
    String type;

    ShipmentSettingsModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory ShipmentSettingsModel.fromJson(Map<String, dynamic> json) => ShipmentSettingsModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
    );


}

class Data {
    List<Shipment> shipment;

    Data({
        required this.shipment,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        shipment: List<Shipment>.from(json["shipment"].map((x) => Shipment.fromJson(x))),
    );


}

class Shipment {
    int id;
    String name;
    String deliveryDelayDays;
    String deliveryCharge;
    String starTime;
    String endTime;
    String timeRange;
    int shipmentDefault;
    String defaultStatus;

    Shipment({
        required this.id,
        required this.name,
        required this.deliveryDelayDays,
        required this.deliveryCharge,
        required this.starTime,
        required this.endTime,
        required this.timeRange,
        required this.shipmentDefault,
        required this.defaultStatus,
    });

    factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        id: json["id"],
        name: json["name"],
        deliveryDelayDays: json["delivery_delay_days"],
        deliveryCharge: json["delivery_charge"],
        starTime: json["star_time"],
        endTime: json["end_time"],
        timeRange: json["time_range"],
        shipmentDefault: json["default"],
        defaultStatus: json["default_status"],
    );


}

class Message {
    List<String> success;

    Message({
        required this.success,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
    );
}
