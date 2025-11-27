
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
    String userStatusValue;
    String userStatus;
    String phoneNumber;

    Data({
        required this.userStatusValue,
        required this.userStatus,
        required this.phoneNumber,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userStatusValue: json["user_status_value"],
        userStatus: json["user_status"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "user_status_value": userStatusValue,
        "user_status": userStatus,
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
