class BasicSettingsModel {
    Message message;
    Data data;
    String type;

    BasicSettingsModel({
        required this.message,
        required this.data,
        required this.type,
    });

    factory BasicSettingsModel.fromJson(Map<String, dynamic> json) => BasicSettingsModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
    );

}

class Data {
    BasicSettings basicSettings;
    BaseCur baseCur;
    List<Language> languages;
    SplashScreen splashScreen;
    List<UserOnboardScreen> userOnboardScreens;
    ImagePaths imagePaths;
    AppImagePaths appImagePaths;

    Data({
        required this.basicSettings,
        required this.baseCur,
        required this.languages,
        required this.splashScreen,
        required this.userOnboardScreens,
        required this.imagePaths,
        required this.appImagePaths,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        basicSettings: BasicSettings.fromJson(json["basic_settings"]),
        baseCur: BaseCur.fromJson(json["base_cur"]),
        languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
        splashScreen: SplashScreen.fromJson(json["splash_screen"]),
        userOnboardScreens: List<UserOnboardScreen>.from(json["user_onboard_screens"].map((x) => UserOnboardScreen.fromJson(x))),
        imagePaths: ImagePaths.fromJson(json["image_paths"]),
        appImagePaths: AppImagePaths.fromJson(json["app_image_paths"]),
    );

}

class AppImagePaths {
    String baseUrl;
    String pathLocation;
    String defaultImage;

    AppImagePaths({
        required this.baseUrl,
        required this.pathLocation,
        required this.defaultImage,
    });

    factory AppImagePaths.fromJson(Map<String, dynamic> json) => AppImagePaths(
        baseUrl: json["base_url"],
        pathLocation: json["path_location"],
        defaultImage: json["default_image"],
    );

}

class BaseCur {
    int id;
    String code;
    String symbol;
    String rate;
    bool both;
    bool senderCurrency;
    bool receiverCurrency;

    BaseCur({
        required this.id,
        required this.code,
        required this.symbol,
        required this.rate,
        required this.both,
        required this.senderCurrency,
        required this.receiverCurrency,
    });

    factory BaseCur.fromJson(Map<String, dynamic> json) => BaseCur(
        id: json["id"],
        code: json["code"],
        symbol: json["symbol"],
        rate: json["rate"],
        both: json["both"],
        senderCurrency: json["senderCurrency"],
        receiverCurrency: json["receiverCurrency"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "symbol": symbol,
        "rate": rate,
        "both": both,
        "senderCurrency": senderCurrency,
        "receiverCurrency": receiverCurrency,
    };
}

class BasicSettings {
    int id;
    String siteName;
    String baseColor;
    String secondaryColor;
    String siteTitle;
    String timezone;
    String siteLogo;
    String siteLogoDark;
    String siteFav;
    String siteFavDark;
    dynamic userRegistration;
    int agreePolicy;

    BasicSettings({
        required this.id,
        required this.siteName,
        required this.baseColor,
        required this.secondaryColor,
        required this.siteTitle,
        required this.timezone,
        required this.siteLogo,
        required this.siteLogoDark,
        required this.siteFav,
        required this.siteFavDark,
        required this.userRegistration,
        required this.agreePolicy,
    });

    factory BasicSettings.fromJson(Map<String, dynamic> json) => BasicSettings(
        id: json["id"],
        siteName: json["site_name"],
        baseColor: json["base_color"],
        secondaryColor: json["secondary_color"],
        siteTitle: json["site_title"],
        timezone: json["timezone"],
        siteLogo: json["site_logo"],
        siteLogoDark: json["site_logo_dark"],
        siteFav: json["site_fav"],
        siteFavDark: json["site_fav_dark"],
        userRegistration: json["user_registration"],
        agreePolicy: json["agree_policy"],
    );

}

class ImagePaths {
    String basePath;
    String pathLocation;
    String defaultImage;
    String productImage;

    ImagePaths({
        required this.basePath,
        required this.pathLocation,
        required this.defaultImage,
        required this.productImage,
    });

    factory ImagePaths.fromJson(Map<String, dynamic> json) => ImagePaths(
        basePath: json["base_path"],
        pathLocation: json["path_location"],
        defaultImage: json["default_image"],
        productImage: json["product_image"],
    );


}

class Language {
    int id;
    String name;
    String code;
    bool status;

    Language({
        required this.id,
        required this.name,
        required this.code,
        required this.status,
    });

    factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        status: json["status"],
    );


}

class SplashScreen {
    int id;
    String version;
    String splashScreenImage;
    dynamic urlTitle;
    dynamic androidUrl;
    dynamic isoUrl;

    SplashScreen({
        required this.id,
        required this.version,
        required this.splashScreenImage,
        required this.urlTitle,
        required this.androidUrl,
        required this.isoUrl,
    });

    factory SplashScreen.fromJson(Map<String, dynamic> json) => SplashScreen(
        id: json["id"],
        version: json["version"],
        splashScreenImage: json["splash_screen_image"],
        urlTitle: json["url_title"],
        androidUrl: json["android_url"],
        isoUrl: json["iso_url"]
    );


}

class UserOnboardScreen {
    int id;
    String title;
    String subTitle;
    String image;
    int status;


    UserOnboardScreen({
        required this.id,
        required this.title,
        required this.subTitle,
        required this.image,
        required this.status,

    });

    factory UserOnboardScreen.fromJson(Map<String, dynamic> json) => UserOnboardScreen(
        id: json["id"],
        title: json["title"],
        subTitle: json["sub_title"],
        image: json["image"],
        status: json["status"]
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
