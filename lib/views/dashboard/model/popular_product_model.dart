
class PopularProductModel {
    Message message;
    PopularProductModelData data;
    String type;

    PopularProductModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory PopularProductModel.fromJson(Map<String, dynamic> json) => PopularProductModel(
        message: Message.fromJson(json["message"]),
        data: PopularProductModelData.fromJson(json["data"]),
        type: json["type"],
    );
}

class PopularProductModelData {
    int currentPage;
    int perPage;
    int totalPages;
    int totalProducts;
    List<Product> product;

    PopularProductModelData({
        required this.currentPage,
        required this.perPage,
        required this.totalPages,
        required this.totalProducts,
        required this.product,
    });

    factory PopularProductModelData.fromJson(Map<String, dynamic> json) => PopularProductModelData(
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
        totalProducts: json["total_products"],
        product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
    );

}

class Product {
    int id;
    int? categoryId;   // <--- ADD THIS
    String? userType;  // <--- ADD THIS
    ProductData data;
    String price;
    String? offerPrice;
    int? purchaseLimit; // <--- 1. ADD THIS VARIABLE
    String uuid;
    int quantity;
    String availableQuantity;
    String orderQuantity;
    String image;
    List<String> images;
    int status;
    int popular;
    String popularStatus;
    String metaImage;
    SubCategory subCategory;
    List<ProductArea> area;
    Shipment shipment;
    String unit;
    String currencyCode;
    String currencySymbol;

    Product({
        required this.id,
        this.categoryId, // <--- ADD THIS
        this.userType,   // <--- ADD THIS
        required this.data,
        required this.price,
        required this.offerPrice,
        this.purchaseLimit, // <--- 2. ADD TO CONSTRUCTOR
        required this.uuid,
        required this.quantity,
        required this.availableQuantity,
        required this.orderQuantity,
        required this.image,
        required this.images,
        required this.status,
        required this.popular,
        required this.popularStatus,
        required this.metaImage,
        required this.subCategory,
        required this.area,
        required this.shipment,
        required this.unit,
        required this.currencyCode,
        required this.currencySymbol,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json['category_id'], // <--- ADD THIS
        userType: json['user_type'],     // <--- ADD THIS
        purchaseLimit: json['purchase_limit'], // <--- 3. MAP FROM JSON
        data: ProductData.fromJson(json["data"]),
        price: json["price"],
        offerPrice: json["offer_price"] ?? "0.0",
        uuid: json["uuid"],
        quantity: json["quantity"],
        availableQuantity: json["available_quantity"],
        orderQuantity: json["order_quantity"],
        image: json["image"],
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x))
            : [],
        status: json["status"],
        popular: json["popular"],
        popularStatus: json["popular_status"],
        metaImage: json["meta_image"],
        subCategory: SubCategory.fromJson(json["sub_category"]),
        area: List<ProductArea>.from(json["area"].map((x) => ProductArea.fromJson(x))),
        shipment: Shipment.fromJson(json["shipment"]),
        unit: json["unit"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
    );

}

class ProductArea {
    int id;
    String slug;
    String name;
    int status;
    DateTime createdAt;
    DateTime updatedAt;
    Pivot pivot;

    ProductArea({
        required this.id,
        required this.slug,
        required this.name,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.pivot,
    });

    factory ProductArea.fromJson(Map<String, dynamic> json) => ProductArea(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
    );
}

class Pivot {
    dynamic productId;
    dynamic areaId;

    Pivot({
        required this.productId,
        required this.areaId,
    });

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        productId: json["product_id"],
        areaId: json["area_id"],
    );
}

class ProductData {
    String name;
    String description;
    String metaTitle;
    String? metaDescription;

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
        metaDescription: json["meta_description"] ?? "",
    );
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
    DateTime createdAt;
    DateTime updatedAt;

    Shipment({
        required this.id,
        required this.name,
        required this.deliveryDelayDays,
        required this.deliveryCharge,
        required this.starTime,
        required this.endTime,
        required this.timeRange,
        required this.shipmentDefault,
        required this.createdAt,
        required this.updatedAt,
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
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
