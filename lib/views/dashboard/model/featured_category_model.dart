class FeaturedCategoryModel {
  Message? message;
  Data? data;

  FeaturedCategoryModel({this.message, this.data});

  FeaturedCategoryModel.fromJson(Map<String, dynamic> json) {
    message =
    json['message'] != null ? Message.fromJson(json['message']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Message {
  List<String>? success;

  Message({this.success});

  Message.fromJson(Map<String, dynamic> json) {
    success = json['success']?.cast<String>();
  }
}

class Data {
  List<FeaturedCategory>? categories;

  Data({this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <FeaturedCategory>[];
      json['categories'].forEach((v) {
        categories!.add(FeaturedCategory.fromJson(v));
      });
    }
  }
}

class FeaturedCategory {
  int id;
  String name;
  String? user_type;
  String image;
  String? slug;

  FeaturedCategory({
    required this.id,
    required this.name,
    this.user_type,
    required this.image,
    this.slug,
  });

  factory FeaturedCategory.fromJson(Map<String, dynamic> json) {
    return FeaturedCategory(
      id: json['id'],
      // Handle cases where name is missing or null
      name: json['name'] ?? "",
      user_type: json['user_type'],
      image: json['image'] ?? "",
      slug: json['slug'],
    );
  }
}