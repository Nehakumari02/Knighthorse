import 'dart:convert';

LogInModel logInModelFromJson(String str) =>
    LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  Message message;
  Data data;
  String type;

  LogInModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
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
  String token;
  UserInfo userInfo;
  Authorization authorization;

  Data({
    required this.token,
    required this.userInfo,
    required this.authorization,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        userInfo: UserInfo.fromJson(json["user_info"]),
        authorization: Authorization.fromJson(json["authorization"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_info": userInfo.toJson(),
        "authorization": authorization.toJson(),
      };
}

class ApiKeys {
  String clientId;
  String secretId;
  String env;

  ApiKeys({
    required this.clientId,
    required this.secretId,
    required this.env,
  });

  factory ApiKeys.fromJson(Map<String, dynamic> json) => ApiKeys(
        clientId: json["client_id"],
        secretId: json["secret_id"],
        env: json["env"],
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "secret_id": secretId,
        "env": env,
      };
}

class Authorization {
  bool status;
  String token;

  Authorization({
    required this.status,
    required this.token,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
      };
}

class UserInfo {
  int id;
  String email;
  dynamic mobileCode;
  dynamic mobile;
  dynamic fullMobile;
  String verificationStatus;
  int emailVerified;
  int kycVerified;
  int twoFactorVerified;
  int twoFactorStatus;
  dynamic twoFactorSecret;

  UserInfo({
    required this.id,
    required this.email,
    required this.mobileCode,
    required this.mobile,
    required this.fullMobile,
    required this.verificationStatus,
    required this.emailVerified,
    required this.kycVerified,
    required this.twoFactorVerified,
    required this.twoFactorStatus,
    required this.twoFactorSecret,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        email: json["email"],
        mobileCode: json["mobile_code"],
        mobile: json["mobile"],
        fullMobile: json["full_mobile"],
    verificationStatus: json["verificationStatus"],

    emailVerified: json["email_verified"],
        kycVerified: json["kyc_verified"],
        twoFactorVerified: json["two_factor_verified"],
        twoFactorStatus: json["two_factor_status"],
        twoFactorSecret: json["two_factor_secret"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "mobile_code": mobileCode,
        "mobile": mobile,
        "full_mobile": fullMobile,
    "verificationStatus": verificationStatus,
        "email_verified": emailVerified,
        "kyc_verified": kycVerified,
        "two_factor_verified": twoFactorVerified,
        "two_factor_status": twoFactorStatus,
        "two_factor_secret": twoFactorSecret,
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
