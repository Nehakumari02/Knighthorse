import '../../dashboard/model/popular_product_model.dart';

class ProductDetailsModel {
    Message message;
    ProductDetailsModelData data;
    String type;

    ProductDetailsModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
        message: Message.fromJson(json["message"]),
        data: ProductDetailsModelData.fromJson(json["data"]),
        type: json["type"],
    );
}

class ProductDetailsModelData {
    Product product;
    List<Product> similarProducts;

    ProductDetailsModelData({
        required this.product,
        required this.similarProducts,
    });

    factory ProductDetailsModelData.fromJson(Map<String, dynamic> json) => ProductDetailsModelData(
        product: Product.fromJson(json["product"]),
        similarProducts: List<Product>.from(json["similar_products"].map((x) => Product.fromJson(x))),
    );
}

// class Product {
//     int id;
//     ProductData data;
//     String price;
//     String offerPrice;
//     String uuid;
//     int quantity;
//     String availableQuantity;
//     String orderQuantity;
//     String image;
//     int status;
//     int popular;
//     String popularStatus;
//     String metaImage;
//     SubCategory subCategory;
//     Area area;
//     Shipment shipment;
//     String unit;

//     Product({
//         required this.id,
//         required this.data,
//         required this.price,
//         required this.offerPrice,
//         required this.uuid,
//         required this.quantity,
//         required this.availableQuantity,
//         required this.orderQuantity,
//         required this.image,
//         required this.status,
//         required this.popular,
//         required this.popularStatus,
//         required this.metaImage,
//         required this.subCategory,
//         required this.area,
//         required this.shipment,
//         required this.unit,
//     });

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         data: ProductData.fromJson(json["data"]),
//         price: json["price"],
//         offerPrice: json["offer_price"],
//         uuid: json["uuid"],
//         quantity: json["quantity"],
//         availableQuantity: json["available_quantity"],
//         orderQuantity: json["order_quantity"],
//         image: json["image"],
//         status: json["status"],
//         popular: json["popular"],
//         popularStatus: json["popular_status"],
//         metaImage: json["meta_image"],
//         subCategory: SubCategory.fromJson(json["sub_category"]),
//         area: Area.fromJson(json["area"]),
//         shipment: Shipment.fromJson(json["shipment"]),
//         unit: json["unit"],
//     );

// }

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
