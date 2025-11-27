class OrderListModel {
    Message message;
    Data data;
    String type;

    OrderListModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
    );

}

class Data {
    List<OrderList> orderList;

    Data({
        required this.orderList,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderList: List<OrderList>.from(json["order_list"].map((x) => OrderList.fromJson(x))),
    );


}

class OrderList {
    int id;
    dynamic date;
    String trxId;
    String defaultCurrencyCode;
    String amount;
    int status;
    String statusValue;
    String uuid;
    DateTime createdAt;
    dynamic updatedAt;

    OrderList({
        required this.id,
        required this.date,
        required this.trxId,
        required this.defaultCurrencyCode,
        required this.amount,
        required this.status,
        required this.statusValue,
        required this.uuid,
        required this.createdAt,
        required this.updatedAt,
    });

    factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        id: json["id"],
        date: json["date"],
        trxId: json["trx_id"],
        defaultCurrencyCode: json["default_currency_code"],
        amount: json["amount"],
        status: json["status"],
        statusValue: json["status_value"],
        uuid: json["uuid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
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
