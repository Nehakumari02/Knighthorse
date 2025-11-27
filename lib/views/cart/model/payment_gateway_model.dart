import 'package:knighthorse/base/widgets/custom_drop_down.dart';

class PaymentGatewaysModel {
  Message message;
  Data data;
  String type;

  PaymentGatewaysModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory PaymentGatewaysModel.fromJson(Map<String, dynamic> json) =>
      PaymentGatewaysModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );
}

class Data {
  ImagePath imagePath;
  List<PaymentGateway> paymentGateways;

  Data({
    required this.imagePath,
    required this.paymentGateways,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imagePath: ImagePath.fromJson(json["image_path"]),
        paymentGateways: List<PaymentGateway>.from(
            json["payment_gateways"].map((x) => PaymentGateway.fromJson(x))),
      );
}

class ImagePath {
  String baseUrl;
  String pathLocation;
  String defaultImage;

  ImagePath({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory ImagePath.fromJson(Map<String, dynamic> json) => ImagePath(
        baseUrl: json["base_url"],
        pathLocation: json["path_location"],
        defaultImage: json["default_image"],
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "path_location": pathLocation,
        "default_image": defaultImage,
      };
}

class PaymentGateway {
  int id;
  String type;
  String name;
  bool crypto;
  dynamic desc;
  int status;
  List<Currency> currencies;

  PaymentGateway({
    required this.id,
    required this.type,
    required this.name,
    required this.crypto,
    required this.desc,
    required this.status,
    required this.currencies,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        crypto: json["crypto"],
        desc: json["desc"],
        status: json["status"],
        currencies: List<Currency>.from(
            json["currencies"].map((x) => Currency.fromJson(x))),
      );
}

class Currency implements DropdownModel {
  int id;
  int paymentGatewayId;
  String name;
  String alias;
  String currencyCode;
  String? currencySymbol;
  String image;
  String minLimit;
  String maxLimit;
  String percentCharge;
  String fixedCharge;
  String rate;

  Currency({
    required this.id,
    required this.paymentGatewayId,
    required this.name,
    required this.alias,
    required this.currencyCode,
    required this.currencySymbol,
    required this.image,
    required this.minLimit,
    required this.maxLimit,
    required this.percentCharge,
    required this.fixedCharge,
    required this.rate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        paymentGatewayId: json["payment_gateway_id"],
        name: json["name"],
        alias: json["alias"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"] ?? " ",
        image: json["image"],
        minLimit: json["min_limit"],
        maxLimit: json["max_limit"],
        percentCharge: json["percent_charge"],
        fixedCharge: json["fixed_charge"],
        rate: json["rate"],
      );

  @override
  String? get leading => image;

  @override
  String get title => name;
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
