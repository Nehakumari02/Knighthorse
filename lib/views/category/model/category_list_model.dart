class CategoryListModel {
    Message message;
    CategoryListModelData data;
    String type;

    CategoryListModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
        message: Message.fromJson(json["message"]),
        data: CategoryListModelData.fromJson(json["data"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
    };
}

class CategoryListModelData {
    List<Category> category;

    CategoryListModelData({
        required this.category,
    });

    factory CategoryListModelData.fromJson(Map<String, dynamic> json) => CategoryListModelData(
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
    };
}

class Category {
    int id;
    CategoryData data;
    String uuid;
    String user_type;
    String image;
    int status;

    Category({
        required this.id,
        required this.data,
        required this.uuid,
        required this.user_type,
        required this.image,
        required this.status,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        data: CategoryData.fromJson(json["data"]),
        uuid: json["uuid"],
        user_type: json["user_type"],
        image: json["image"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
        "uuid": uuid,
        "user_type":user_type,
        "image": image,
        "status": status,
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
