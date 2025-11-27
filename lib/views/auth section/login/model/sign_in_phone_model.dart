
class LoginPhoneModel {
    Message message;
    Data data;
    String type;

    LoginPhoneModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory LoginPhoneModel.fromJson(Map<String, dynamic> json) => LoginPhoneModel(
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

    Data({
        required this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
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
