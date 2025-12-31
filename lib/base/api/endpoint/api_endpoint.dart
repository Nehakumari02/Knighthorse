import 'package:dynamic_languages/dynamic_languages.dart';

class ApiConfig {
  static const String mainDomain = "https://thebudgetpe.com/demo/Knighthorse/app";
  // static const String mainDomain = "http://192.168.1.113:8000";

  static const String baseUrl = "$mainDomain/api/v1";
  static const String languageUrl = "$baseUrl/settings/languages";
}

enum ApiEndpoint {
  // Settings
  basicSettings('/settings/basic-settings'),
  deliverySettings('/settings/delivery'),
  shipmentSettings('/settings/shipment'),

  // Auth
  login('/login'),
  forgotPassword('/password/forgot/find/user'),
  forgotPasswordVerifyCode('/password/forgot/verify/code'),
  resendForgotOtpCode('/password/forgot/resend/code'),
  resetPassword('/password/forgot/reset'),

  //login with phone number
  loginPhoneCode('/authorize/phone/send/code'),
  verifyPhoneCode('/authorize/phone/verify/code'),
  resendPhoneCode('/authorize/phone/resend/code'),

  register('/register'),
  emailOtpVerify('/authorize/mail/verify/code'),
  resendEmailOtp('/authorize/mail/resend/code'),

  logOut('/user/logout'),

  // Dashboard
  area('/product/area'),
  areaSelect('/product/area/wise'),
  bannerOffer('/settings/frontend/data'),
  popularProduct('/product/popular'),
  productDetails('/product/details'),
  specialOffer('/product/special/offer'),
  allProductList('/product/list'),
  featuredCategories('/product/featuredCategories'),

  // category
  categoryList('/product/category'),
  subCategoryList('/product/sub-category'),

  // Products
  subCategoryProductList('/product/sub-category/product'),

  // cart section
  userCart('/user/user/cart'),
  addToCart('/user/user/cart/store/single'),
  itemDelete('/user/user/cart/delete'),
  cartUpdate('/user/user/cart/store'),

  // search product
  searchProduct('/settings/search/product'),

  // Order
  orderList('/user/order-details/'),
  orderDetails('/user/order-details/details'),

  //payment history
  paymentGateWays('/user/payment-gateways'),
  paymentHistory('/user/order-details/payment/history'),

  // checkout
  checkOutByCash("/user/cash/payment/submit"),
  checkOutByOnline("/user/automatic/submit"),

  // Profile
  profileInfo('/user/profile/info'),
  updateProfile('/user/profile/info/update'),
  updatePassword('/user/profile/password/update'),
  deleteAccount('/user/profile/delete');

  final String path;
  const ApiEndpoint(this.path);

  /// Returns the full URL with optional query parameters
  String url({Map<String, String>? params}) {
    var fullUrl = "${ApiConfig.baseUrl}$path";
    if (params != null && params.isNotEmpty) {
      fullUrl +=
          '?${params.entries.map((e) => '${e.key}=${e.value}').join('&')}&?lang=${DynamicLanguage.selectedLanguage.value}';
    } else {
      fullUrl += '?lang=${DynamicLanguage.selectedLanguage.value}';
    }
    return fullUrl;
  }

  /// Convenience method to append query parameters
  String withParams(Map<String, String> params) => url(params: params);
}
