class SubCategoryListModel {
    Message message;
    SubCategoryListModelData data;
    String type;

    SubCategoryListModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory SubCategoryListModel.fromJson(Map<String, dynamic> json) => SubCategoryListModel(
        message: Message.fromJson(json["message"]),
        data: SubCategoryListModelData.fromJson(json["data"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
    };
}

class SubCategoryListModelData {
    List<SubCategory> subCategory;

    SubCategoryListModelData({
        required this.subCategory,
    });

    factory SubCategoryListModelData.fromJson(Map<String, dynamic> json) => SubCategoryListModelData(
        subCategory: List<SubCategory>.from(json["sub_category"].map((x) => SubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
    };
}

class SubCategory {
    int id;
    CategoryData data;
    String uuid;
    String image;
    int status;
    CategorySection categorySection;

    SubCategory({
        required this.id,
        required this.data,
        required this.uuid,
        required this.image,
        required this.status,
        required this.categorySection,
    });

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        data: CategoryData.fromJson(json["data"]),
        uuid: json["uuid"],
        image: json["image"],
        status: json["status"],
        categorySection: CategorySection.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
        "uuid": uuid,
        "image": image,
        "status": status,
        "categorySection": categorySection.toJson(),
    };
}

class CategorySection {
    int id;
    CategoryData data;
    String uuid;
    String image;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    CategorySection({
        required this.id,
        required this.data,
        required this.uuid,
        required this.image,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CategorySection.fromJson(Map<String, dynamic> json) => CategorySection(
        id: json["id"],
        data: CategoryData.fromJson(json["data"]),
        uuid: json["uuid"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
        "uuid": uuid,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class CategoryData {
    String name;
    String title;

    CategoryData({
        required this.name,
        required this.title,
    });

    factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        name: json["name"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
    };
}

class Message {
    List<String> success;

    Message({
        required this.success,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
    };
}
