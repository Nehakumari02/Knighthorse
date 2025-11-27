
class GoogleLoginModel1 {
    Message message;
    Data data;
    String type;

    GoogleLoginModel1({
        required this.message,
        required this.data,
        required this.type,
    });

    factory GoogleLoginModel1.fromJson(Map<String, dynamic> json) => GoogleLoginModel1(
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
    String redirectUrl;

    Data({
        required this.redirectUrl,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        redirectUrl: json["redirect_url"],
    );

    Map<String, dynamic> toJson() => {
        "redirect_url": redirectUrl,
    };
}

class Message {
    String success;

    Message({
        required this.success,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
    };
}
