class BannerOfferModel {
  Message message;
  Data data;
  String type;

  BannerOfferModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory BannerOfferModel.fromJson(Map<String, dynamic> json) =>
      BannerOfferModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );
}

class Data {
  List<OfferBanner> banner;


  Data({
    required this.banner,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banner:
            List<OfferBanner>.from(json["banner"].map((x) => OfferBanner.fromJson(x))),
      );
}

class OfferBanner {
  String id;
  String image;

  OfferBanner({
    required this.id,
    required this.image,
  });

  factory OfferBanner.fromJson(Map<String, dynamic> json) => OfferBanner(
        id: json["id"],
        image: json["image"],
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
