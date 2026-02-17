class ProfileInfoModel {
    Message message;
    Data data;
    String type;

    ProfileInfoModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory ProfileInfoModel.fromJson(Map<String, dynamic> json) => ProfileInfoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
    );

}

class Data {
    UserInfo userInfo;
    UserWallet? userWallet;
    ImagePaths imagePaths;

    Data({
        required this.userInfo,
        required this.userWallet,
        required this.imagePaths,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userInfo: UserInfo.fromJson(json["user_info"]),
        userWallet: json["user_wallet"] != null
    ? UserWallet.fromJson(json["user_wallet"])
    : null,
        imagePaths: ImagePaths.fromJson(json["image_paths"]),
    );

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

}

class UserInfo {
    int id;
    String firstname;
    String lastname;
    String username;
    String email;
    String mobileCode;
    dynamic mobile;
    dynamic image;
    String address;
    String user_type;
    String? assign_to; // 1. Use String? because it can be null
    String? assign_to_email; // 👈 Add this

    UserInfo({
        required this.id,
        required this.firstname,
        required this.lastname,
        required this.username,
        required this.email,
        required this.mobileCode,
        required this.mobile,
        required this.image,
        required this.address,
        required this.user_type,
        this.assign_to,
        this.assign_to_email, // 👈 Add this
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        mobileCode: json["mobile_code"] ?? "",
        mobile: json["mobile"] ?? "",
        image: json["image"] ?? "",
        address: json["address"],
        user_type: json["user_type"],
        assign_to: json["assign_to"],
        assign_to_email: json["assign_to_email"]?.toString() ?? "", // 👈 Map it here
    );

}

class UserWallet {
    int id;
    int userId;
    int currencyId;
    String balance;
    bool status;

    UserWallet({
        required this.id,
        required this.userId,
        required this.currencyId,
        required this.balance,
        required this.status,
    });

    factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
        id: json["id"],
        userId: json["user_id"],
        currencyId: json["currency_id"],
        balance: json["balance"],
        status: json["status"],
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
