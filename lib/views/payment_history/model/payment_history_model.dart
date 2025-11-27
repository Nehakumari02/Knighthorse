class PaymentHistoryModel {
    Message message;
    Data data;
    String type;

    PaymentHistoryModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
    );


}

class Data {
    List<PaymentHistory> paymentHistory;

    Data({
        required this.paymentHistory,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentHistory: List<PaymentHistory>.from(json["payment_history"].map((x) => PaymentHistory.fromJson(x))),
    );


}

class PaymentHistory {
    int id;
    dynamic date;
    String orderNumber;
    String defaultCurrencyCode;
    String amount;
    String method;
    String uuid;
    DateTime createdAt;
    DateTime? updatedAt;

    PaymentHistory({
        required this.id,
        required this.date,
        required this.orderNumber,
        required this.defaultCurrencyCode,
        required this.amount,
        required this.method,
        required this.uuid,
        required this.createdAt,
        required this.updatedAt,
    });

    factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
        id: json["id"],
        date: json["date"],
        orderNumber: json["order_number"],
        defaultCurrencyCode: json["default_currency_code"],
        amount: json["amount"],
        method: json["method"],
        uuid: json["uuid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
