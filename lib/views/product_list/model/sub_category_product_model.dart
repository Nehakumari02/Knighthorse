class SubCategoryProductModel {
    Message message;
    SubCategoryProductModelData data;
    String type;

    SubCategoryProductModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory SubCategoryProductModel.fromJson(Map<String, dynamic> json) => SubCategoryProductModel(
        message: Message.fromJson(json["message"]),
        data: SubCategoryProductModelData.fromJson(json["data"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
    };
}

class SubCategoryProductModelData {
    int currentPage;
    int perPage;
    int totalPages;
    int totalProducts;
    List<Product> product;
    String currencyCode;
    String currencySymbol;

    SubCategoryProductModelData({
        required this.currentPage,
        required this.perPage,
        required this.totalPages,
        required this.totalProducts,
        required this.product,
        required this.currencyCode,
        required this.currencySymbol,
    });

    factory SubCategoryProductModelData.fromJson(Map<String, dynamic> json) => SubCategoryProductModelData(
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
        totalProducts: json["total_products"],
        product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
        "total_products": totalProducts,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "currency_code": currencyCode,
        "currency_symbol": currencySymbol,
    };
}

class Product {
    int id;
    ProductData data;
    String price;
    String? offerPrice;
    String uuid;
    int quantity;
    String availableQuantity;
    String image;
    int status;
    int popular;
    String popularStatus;
    String metaImage;
    SubCategory subCategory;
    Area area;
    Shipment shipment;
    String unit;

    Product({
        required this.id,
        required this.data,
        required this.price,
        required this.offerPrice,
        required this.uuid,
        required this.quantity,
        required this.availableQuantity,
        required this.image,
        required this.status,
        required this.popular,
        required this.popularStatus,
        required this.metaImage,
        required this.subCategory,
        required this.area,
        required this.shipment,
        required this.unit,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        data: ProductData.fromJson(json["data"]),
        price: json["price"],
        offerPrice: json["offer_price"],
        uuid: json["uuid"],
        quantity: json["quantity"],
        availableQuantity: json["available_quantity"],
        image: json["image"],
        status: json["status"],
        popular: json["popular"],
        popularStatus: json["popular_status"],
        metaImage: json["meta_image"],
        subCategory: SubCategory.fromJson(json["sub_category"]),
        area: Area.fromJson(json["area"]),
        shipment: Shipment.fromJson(json["shipment"]),
        unit: json["unit"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
        "price": price,
        "offer_price": offerPrice,
        "uuid": uuid,
        "quantity": quantity,
        "available_quantity": availableQuantity,
        "image": image,
        "status": status,
        "popular": popular,
        "popular_status": popularStatus,
        "meta_image": metaImage,
        "sub_category": subCategory.toJson(),
        "area": area.toJson(),
        "shipment": shipment.toJson(),
        "unit": unit,
    };
}

class Area {
    int id;
    String slug;
    String name;
    int status;

    Area({
        required this.id,
        required this.slug,
        required this.name,
        required this.status,
    });

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "status": status,
    };
}

class ProductData {
    String name;
    String description;
    String metaTitle;
    String metaDescription;

    ProductData({
        required this.name,
        required this.description,
        required this.metaTitle,
        required this.metaDescription,
    });

    factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        name: json["name"],
        description: json["description"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
    };
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

    Shipment({
        required this.id,
        required this.name,
        required this.deliveryDelayDays,
        required this.deliveryCharge,
        required this.starTime,
        required this.endTime,
        required this.timeRange,
        required this.shipmentDefault,
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
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "delivery_delay_days": deliveryDelayDays,
        "delivery_charge": deliveryCharge,
        "star_time": starTime,
        "end_time": endTime,
        "time_range": timeRange,
        "default": shipmentDefault,
    };
}

class SubCategory {
    String name;
    String title;

    SubCategory({
        required this.name,
        required this.title,
    });

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
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
