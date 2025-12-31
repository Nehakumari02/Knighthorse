
class VerifyPhoneCodeModel {
    Message message;
    Data data;
    String type;

    VerifyPhoneCodeModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory VerifyPhoneCodeModel.fromJson(Map<String, dynamic> json) => VerifyPhoneCodeModel(
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
    String? accessToken; // Added
    String userStatusValue;
    String userStatus;
    String phoneNumber;
    User? user; // Added

    Data({
        this.accessToken,
        required this.userStatusValue,
        required this.userStatus,
        required this.phoneNumber,
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"] ?? "",
        userStatusValue: json["user_status_value"],
        userStatus: json["user_status"],
        phoneNumber: json["phone_number"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user_status_value": userStatusValue,
        "user_status": userStatus,
        "phone_number": phoneNumber,
        "user": user?.toJson(),
    };
}

class User {
    int userId;
    String fullName;
    String emailAddress;
    String phoneNumber;

    User({
        required this.userId,
        required this.fullName,
        required this.emailAddress,
        required this.phoneNumber,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        fullName: json["full_name"],
        emailAddress: json["email_address"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "email_address": emailAddress,
        "phone_number": phoneNumber,
    };
}

class Message {
    Success success;

    Message({
        required this.success,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: Success.fromJson(json["success"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success.toJson(),
    };
}

class Success {
    String message;

    Success({
        required this.message,
    });

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
