class DeliverySettingsModel {
    Message message;
    Data data;
    String type;

    DeliverySettingsModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory DeliverySettingsModel.fromJson(Map<String, dynamic> json) => DeliverySettingsModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
    );

}

class Data {
    Delivery delivery;

    Data({
        required this.delivery,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        delivery: Delivery.fromJson(json["delivery"]),
    );

}

class Delivery {
    int id;
    int bagPrice;
    int amountSpend;
    int deliveryCount;
    int bagStatus;
    int freeDeliveryStatus;

    Delivery({
        required this.id,
        required this.bagPrice,
        required this.amountSpend,
        required this.deliveryCount,
        required this.bagStatus,
        required this.freeDeliveryStatus,
    });

    factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        id: json["id"],
        bagPrice: json["bag_price"],
        amountSpend: json["amount_spend"],
        deliveryCount: json["delivery_count"],
        bagStatus: json["bag_status"],
        freeDeliveryStatus: json["free_delivery_status"],
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
