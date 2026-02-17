class OrderDetailsModel {
  Message message;
  OrderDetailsModelData data;
  String type;

  OrderDetailsModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        message: Message.fromJson(json["message"]),
        data: OrderDetailsModelData.fromJson(json["data"]),
        type: json["type"],
      );
}

class OrderDetailsModelData {
  Transaction transaction;
  DataBookingData bookingData;
  String currencySymbol;

  OrderDetailsModelData({
    required this.transaction,
    required this.bookingData,
    required this.currencySymbol,
  });

  factory OrderDetailsModelData.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModelData(
        transaction: Transaction.fromJson(json["transaction"]),
        bookingData: DataBookingData.fromJson(json["booking_data"]),
        currencySymbol: json["currency_symbol"] ?? "\$",
      );
}

class DataBookingData {
  List<Product> products;
  DeliveryInfo deliveryInfo;
  BookingDataUserCart userCart;

  DataBookingData({
    required this.products,
    required this.deliveryInfo,
    required this.userCart,
  });

  factory DataBookingData.fromJson(Map<String, dynamic> json) =>
      DataBookingData(
        products: List<Product>.from(
            json["products"]?.map((x) => Product.fromJson(x)) ?? []),
        deliveryInfo: DeliveryInfo.fromJson(json["delivery_info"]),
        userCart: BookingDataUserCart.fromJson(json["user_cart"]),
      );
}

// 👇👇👇 CRITICAL FIXES HERE 👇👇👇
class DeliveryInfo {
  String address;
  String phone;
  String email;
  String deliveryCharge;
  String notes;
  String reusableBag;
  String deliveryType;

  DeliveryInfo({
    required this.address,
    required this.phone,
    required this.email,
    required this.deliveryCharge,
    required this.notes,
    required this.reusableBag,
    required this.deliveryType,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
    // We use ?? "" to default to empty string if server sends null
    address: json["address"] ?? "",
    phone: json["phone"] ?? "",
    email: json["email"] ?? "",
    deliveryCharge: json["delivery_charge"]?.toString() ?? "0",
    notes: json["notes"] ?? "", // 👈 THIS WAS YOUR CRASH
    reusableBag: json["reusable_bag"]?.toString() ?? "",
    deliveryType: json["delivery_type"] ?? "",
  );
}

class Product {
  String id;
  String name;
  String price;
  String color;
  String mainPrice;
  String offerPrice;
  String image;
  String quantity;
  String? subCategory;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.color,
    required this.mainPrice,
    required this.offerPrice,
    required this.image,
    required this.quantity,
    this.subCategory, // <--- Add to constructor
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"]?.toString() ?? "",
    name: json["name"] ?? "",
    price: json["price"]?.toString() ?? "0",
    color: json["color"] ?? "",
    mainPrice: json["main_price"]?.toString() ?? "0",
    offerPrice: json["offer_price"]?.toString() ?? "0",
    image: json["image"] ?? "",
    quantity: json["quantity"]?.toString() ?? "0",
    subCategory: json["sub_category"],
  );
}

class BookingDataUserCart {
  String subTotal;
  String deliveryCharge;
  String total;

  BookingDataUserCart({
    required this.subTotal,
    required this.deliveryCharge,
    required this.total,
  });

  factory BookingDataUserCart.fromJson(Map<String, dynamic> json) =>
      BookingDataUserCart(
        subTotal: json["sub_total"]?.toString() ?? "0",
        deliveryCharge: json["delivery_charge"]?.toString() ?? "0",
        total: json["total"]?.toString() ?? "0",
      );
}

// 👇👇👇 CRITICAL FIXES HERE TOO 👇👇👇
class Transaction {
  int id;
  String uuid;
  String trxId;
  String paymentMethod;
  String paymentGatewayCharge;
  int status;
  String statusValue;
  String createdAt;
  dynamic paymentGateway;
  User? user;
  List<OrderShipment> orderShipment;

  Transaction({
    required this.id,
    required this.uuid,
    required this.trxId,
    required this.paymentMethod,
    required this.paymentGatewayCharge,
    required this.status,
    required this.statusValue,
    required this.createdAt,
    required this.paymentGateway,
    required this.user,
    required this.orderShipment,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"] ?? 0,
    uuid: json["uuid"] ?? "",
    trxId: json["trx_id"] ?? "",
    paymentMethod: json["payment_method"] ?? "", // 👈 Fixed possible null
    paymentGatewayCharge: json["payment_gateway_charge"]?.toString() ?? "0",
    status: json["status"] ?? 0,
    statusValue: json["status_value"] ?? "",
    createdAt: json["created_at"] ?? "",
    paymentGateway: json["payment_gateway"],
    user: json["user"] != null ? User.fromJson(json["user"]) : null,
    orderShipment: json["order_shipment"] != null
        ? List<OrderShipment>.from(json["order_shipment"].map((x) => OrderShipment.fromJson(x)))
        : [],
  );
}

class OrderShipment {
  int id;
  int productOrderId;
  int shipmentId;
  int userId;
  String trackingNumber;
  String? trackingLink;    // 👈 Changed to Nullable (No 'required')
  String? courierCompany;  // 👈 Changed to Nullable (No 'required')
  String startTime;
  String endTime;
  DateTime deliveryDate;
  String deliveryCharge;
  int shipmentStatus;
  Shipment shipment;
  ProductOrder productOrder;

  OrderShipment({
    required this.id,
    required this.productOrderId,
    required this.shipmentId,
    required this.userId,
    required this.trackingNumber,
    this.trackingLink,    // 👈 Removed 'required'
    this.courierCompany,  // 👈 Removed 'required'
    required this.startTime,
    required this.endTime,
    required this.deliveryDate,
    required this.deliveryCharge,
    required this.shipmentStatus,
    required this.shipment,
    required this.productOrder,
  });

  factory OrderShipment.fromJson(Map<String, dynamic> json) => OrderShipment(
    id: json["id"],
    productOrderId: json["product_order_id"],
    shipmentId: json["shipment_id"],
    userId: json["user_id"],
    trackingNumber: json["tracking_number"] ?? "",
    trackingLink: json["tracking_link"],     // 👈 Directly assigned (can be null)
    courierCompany: json["courier_company"], // 👈 Directly assigned (can be null)
    startTime: json["start_time"] ?? "",
    endTime: json["end_time"] ?? "",
    deliveryDate: DateTime.parse(json["delivery_date"]),
    deliveryCharge: json["delivery_charge"]?.toString() ?? "0",
    shipmentStatus: json["shipment_status"],
    shipment: Shipment.fromJson(json["shipment"]),
    productOrder: ProductOrder.fromJson(json["product_order"]),
  );
}

class ProductOrder {
  int id;
  int userId;
  ProductOrderBookingData bookingData;
  dynamic paymentGatewayCurrencyId;
  int orderId;
  String trxId;
  int bookingExpSeconds;
  String paymentMethod;
  String uuid;
  String totalCharge;
  String price;
  String payablePrice;
  dynamic gatewayPayablePrice;
  dynamic message;
  String type;
  dynamic paymentCurrency;
  String remark;
  dynamic details;
  int status;
  dynamic rejectReason;

  ProductOrder({
    required this.id,
    required this.userId,
    required this.bookingData,
    required this.paymentGatewayCurrencyId,
    required this.orderId,
    required this.trxId,
    required this.bookingExpSeconds,
    required this.paymentMethod,
    required this.uuid,
    required this.totalCharge,
    required this.price,
    required this.payablePrice,
    required this.gatewayPayablePrice,
    required this.message,
    required this.type,
    required this.paymentCurrency,
    required this.remark,
    required this.details,
    required this.status,
    required this.rejectReason,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) => ProductOrder(
    id: json["id"],
    userId: json["user_id"],
    bookingData: ProductOrderBookingData.fromJson(json["booking_data"]),
    paymentGatewayCurrencyId: json["payment_gateway_currency_id"],
    orderId: json["order_id"],
    trxId: json["trx_id"],
    bookingExpSeconds: json["booking_exp_seconds"],
    paymentMethod: json["payment_method"] ?? "",
    uuid: json["uuid"],
    totalCharge: json["total_charge"]?.toString() ?? "",
    price: json["price"]?.toString() ?? "",
    payablePrice: json["payable_price"]?.toString() ?? "",
    gatewayPayablePrice: json["gateway_payable_price"],
    message: json["message"],
    type: json["type"] ?? "",
    paymentCurrency: json["payment_currency"],
    remark: json["remark"] ?? "",
    details: json["details"],
    status: json["status"],
    rejectReason: json["reject_reason"],
  );
}

class ProductOrderBookingData {
  BookingDataData data;

  ProductOrderBookingData({
    required this.data,
  });

  factory ProductOrderBookingData.fromJson(Map<String, dynamic> json) =>
      ProductOrderBookingData(
        data: BookingDataData.fromJson(json["data"]),
      );
}

class BookingDataData {
  DataUserCart userCart;
  DeliveryInfo deliveryInfo;
  String paymentMethod;
  String totalCost;
  ShipmentInfo shipmentInfo;

  BookingDataData({
    required this.userCart,
    required this.deliveryInfo,
    required this.paymentMethod,
    required this.totalCost,
    required this.shipmentInfo,
  });

  factory BookingDataData.fromJson(Map<String, dynamic> json) =>
      BookingDataData(
        userCart: DataUserCart.fromJson(json["user_cart"]),
        deliveryInfo: DeliveryInfo.fromJson(json["delivery_info"]),
        paymentMethod: json["payment_method"] ?? "",
        totalCost: json["total_cost"]?.toString() ?? "",
        shipmentInfo: ShipmentInfo.fromJson(json["shipment_info"]),
      );
}

class ShipmentInfo {
  String? togetherTimeSlotStart;
  String? togetherTimeSlotEnd;
  DateTime? togetherDeliveryDate;

  ShipmentInfo({
    required this.togetherTimeSlotStart,
    required this.togetherTimeSlotEnd,
    required this.togetherDeliveryDate,
  });

  factory ShipmentInfo.fromJson(Map<String, dynamic> json) => ShipmentInfo(
    togetherTimeSlotStart: json["together_time_slot_start"] ?? "",
    togetherTimeSlotEnd: json["together_time_slot_end"] ?? "",
    togetherDeliveryDate: json["together_delivery_date"] != null
        ? DateTime.parse(json["together_delivery_date"])
        : null,
  );
}

class DataUserCart {
  int id;
  List<Product> data;
  int userId;
  dynamic sessionId;
  int status;
  String uuid;
  String subTotal;
  int checkout;
  DateTime createdAt;
  DateTime updatedAt;

  DataUserCart({
    required this.id,
    required this.data,
    required this.userId,
    required this.sessionId,
    required this.status,
    required this.uuid,
    required this.subTotal,
    required this.checkout,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataUserCart.fromJson(Map<String, dynamic> json) => DataUserCart(
    id: json["id"],
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
    userId: json["user_id"],
    sessionId: json["session_id"],
    status: json["status"],
    uuid: json["uuid"],
    subTotal: json["sub_total"]?.toString() ?? "0",
    checkout: json["checkout"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    name: json["name"] ?? "",
    deliveryDelayDays: json["delivery_delay_days"]?.toString() ?? "",
    deliveryCharge: json["delivery_charge"]?.toString() ?? "",
    starTime: json["star_time"] ?? "",
    endTime: json["end_time"] ?? "",
    timeRange: json["time_range"] ?? "",
    shipmentDefault: json["default"] ?? 0,
  );
}

class User {
  int id;
  String firstname;
  String lastname;
  String username;
  String email;
  dynamic mobileCode;
  dynamic mobile;
  dynamic fullMobile;
  dynamic driver;
  dynamic referralId;
  dynamic image;
  int status;
  int freeDeliveryStatus;
  dynamic totalSpendAmount;
  dynamic address;
  String fullname;
  String userImage;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.mobileCode,
    required this.mobile,
    required this.fullMobile,
    required this.driver,
    required this.referralId,
    required this.image,
    required this.status,
    required this.freeDeliveryStatus,
    required this.totalSpendAmount,
    required this.address,
    required this.fullname,
    required this.userImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstname: json["firstname"] ?? "",
    lastname: json["lastname"] ?? "",
    username: json["username"] ?? "",
    email: json["email"] ?? "",
    mobileCode: json["mobile_code"],
    mobile: json["mobile"],
    fullMobile: json["full_mobile"],
    driver: json["driver"],
    referralId: json["referral_id"],
    image: json["image"],
    status: json["status"],
    freeDeliveryStatus: json["free_delivery_status"],
    totalSpendAmount: json["total_spend_amount"],
    address: json["address"],
    fullname: json["fullname"] ?? "",
    userImage: json["userImage"] ?? "",
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