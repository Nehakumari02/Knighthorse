import 'package:get/get.dart';

class CartModel {
  Message message;
  Data data;
  String type;

  CartModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );
}

class Data {
  UserCart? userCart;
  List<CartDatum> cartData;

  Data({
    required this.userCart,
    required this.cartData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userCart: json['user_cart'] != null
            ? UserCart.fromJson(json["user_cart"])
            : null,
        cartData: List<CartDatum>.from(
            json["cart_data"].map((x) => CartDatum.fromJson(x))),
      );
}

class CartDatum {
  String id;
  String name;
  String price;
  String mainPrice;
  String? shipmentType;
  String? offerPrice;
  String? image;
  RxInt quantity;
  String? availableQuantity;

  CartDatum({
    required this.id,
    required this.name,
    required this.price,
    required this.mainPrice,
    required this.shipmentType,
    required this.offerPrice,
    required this.image,
    required this.availableQuantity,
    required int quantity,
  }) : quantity = quantity.obs;

  factory CartDatum.fromJson(Map<String, dynamic> json) => CartDatum(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        mainPrice: json["main_price"],
        shipmentType: json["shipment_type"],
        offerPrice: json["offer_price"] ?? "0.00",
        image: json["image"],
        availableQuantity: json["available_quantity"] ?? "1",
        quantity: json["quantity"] is int
            ? json["quantity"]
            : int.parse(json["quantity"].toString()),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "main_price": mainPrice,
        "shipment_type": shipmentType,
        "offer_price": offerPrice,
        "image": image,
        "quantity": quantity.value,
        "available_quantity": availableQuantity,
      };

  factory CartDatum.fromMap(Map<String, dynamic> map) => CartDatum(
      id: map["id"],
      name: map["name"],
      price: map["price"],
      mainPrice: map["main_price"],
      shipmentType: map["shipment_type"],
      offerPrice: map["offer_price"],
      image: map["image"],
      quantity: map["quantity"],
      availableQuantity: map["available_quantity"]);
}

class UserCart {
  int id;
  int userId;
  String? sessionId;
  int status;
  String uuid;
  String subTotal;
  int checkout;

  UserCart(
      {required this.id,
      required this.userId,
      required this.sessionId,
      required this.status,
      required this.uuid,
      required this.subTotal,
      required this.checkout});

  factory UserCart.fromJson(Map<String, dynamic> json) => UserCart(
      id: json["id"],
      userId: json["user_id"],
      sessionId: json["session_id"] ?? "",
      status: json["status"],
      uuid: json["uuid"],
      subTotal: json["sub_total"],
      checkout: json["checkout"]);
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
