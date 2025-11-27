class GoogleLoginModel {
  Message message;
  Data data;
  String type;

  GoogleLoginModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory GoogleLoginModel.fromJson(Map<String, dynamic> json) =>
      GoogleLoginModel(
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

class Authorization {
  bool status;
  String? token;

  Authorization({
    required this.status,
    this.token,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        status: json["status"],
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token ?? "",
      };
}
 

      
class UserInfo {
  int id;
  dynamic firstName;
  dynamic lastName;
  String fullname;
  String username;
  String email;
  dynamic emailVerified;

  UserInfo({
    required this.id,
    this.firstName,
    this.lastName,
    required this.fullname,
    required this.username,
    required this.email,
    required this.emailVerified,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? '',
        fullname: json["fullname"],
        username: json["username"],
        email: json["email"],
        emailVerified: json["email_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName ?? "",
        "fullname": fullname,
        "username": username,
        "email": email,
        "email_verified": emailVerified,
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
