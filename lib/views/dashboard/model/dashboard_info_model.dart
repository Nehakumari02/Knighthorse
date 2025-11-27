import 'dart:convert';

DashboardInfoModel dashboardInfoModelFromJson(String str) =>
    DashboardInfoModel.fromJson(json.decode(str));

String dashboardInfoModelToJson(DashboardInfoModel data) =>
    json.encode(data.toJson());

class DashboardInfoModel {
  Message message;
  Data data;
  String type;

  DashboardInfoModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory DashboardInfoModel.fromJson(Map<String, dynamic> json) =>
      DashboardInfoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class Data {
  UserWallet userWallet;
  int totalTransactions;
  int completeTransactions;
  int pendingTransactions;
  int totalAddMoney;
  int totalMoneyOut;
  int totalFundTransfer;
  int totalFundReceived;
  int pinStatus;
  ImagePaths profileImagePaths;
  ImagePaths currencyImagePaths;

  Data({
    required this.userWallet,
    required this.totalTransactions,
    required this.completeTransactions,
    required this.pendingTransactions,
    required this.totalAddMoney,
    required this.totalMoneyOut,
    required this.totalFundTransfer,
    required this.totalFundReceived,
    required this.pinStatus,
    required this.profileImagePaths,
    required this.currencyImagePaths,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userWallet: UserWallet.fromJson(json["user_wallet"]),
        totalTransactions: json["total_transactions"],
        completeTransactions: json["complete_transactions"],
        pendingTransactions: json["pending_transactions"],
        totalAddMoney: json["total_add_money"],
        totalMoneyOut: json["total_money_out"],
        totalFundTransfer: json["total_fund_transfer"],
        totalFundReceived: json["total_fund_received"],
        pinStatus: json["pin_status"],
        profileImagePaths: ImagePaths.fromJson(json["profile_image_paths"]),
        currencyImagePaths: ImagePaths.fromJson(json["currency_image_paths"]),
      );

  Map<String, dynamic> toJson() => {
        "user_wallet": userWallet.toJson(),
        "total_transactions": totalTransactions,
        "complete_transactions": completeTransactions,
        "pending_transactions": pendingTransactions,
        "total_add_money": totalAddMoney,
        "total_money_out": totalMoneyOut,
        "total_fund_transfer": totalFundTransfer,
        "total_fund_received": totalFundReceived,
        "pin_status": pinStatus,
        "profile_image_paths": profileImagePaths.toJson(),
        "currency_image_paths": currencyImagePaths.toJson(),
      };
}

class ImagePaths {
  String baseUrl;
  String pathLocation;
  String defaultImage;

  ImagePaths({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory ImagePaths.fromJson(Map<String, dynamic> json) => ImagePaths(
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

class UserWallet {
  String currency;
  double balance;
  String name;
  String flag;
  int rate;

  UserWallet({
    required this.currency,
    required this.balance,
    required this.name,
    required this.flag,
    required this.rate,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
        currency: json["currency"],
        balance: json["balance"]?.toDouble(),
        name: json["name"],
        flag: json["flag"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "balance": balance,
        "name": name,
        "flag": flag,
        "rate": rate,
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
