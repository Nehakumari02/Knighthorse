import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../views/auth section/auth_model/forgot_password_and_verify_model.dart';
import '../../../views/auth section/auth_model/register_model.dart';
import '../../../views/auth section/login/model/google_login_model.dart';
import '../../../views/auth section/login/model/sign_in_model.dart';
import '../../../views/auth section/login/model/sign_in_phone_model.dart';
import '../../../views/auth section/login/model/verify_phone_code_model.dart';
import '../../utils/basic_import.dart';
import '../../utils/local_storage.dart';
import '../endpoint/api_endpoint.dart';
import '../method/request_process.dart';
import '../model/common_success_model.dart';
import 'google_auth_services.dart';
import '../method/api_method.dart' show log;

class AuthServices {
  static late LogInModel _logInModel;
  LogInModel get logInModel => _logInModel;

  static late GoogleLoginModel _googleLoginModel;
  GoogleLoginModel get googleLoginModel => _googleLoginModel;

  static late LoginPhoneModel _loginPhoneModel;
  LoginPhoneModel get loginPhoneModel => _loginPhoneModel;

  static late CommonSuccessModel _commonSuccessModel;
  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  static late ForgotPasswordAndVerifyModel _forgotPasswordAndVerifyModel;
  ForgotPasswordAndVerifyModel get forgotPasswordAndVerifyModel =>
      _forgotPasswordAndVerifyModel;

  static late VerifyPhoneCodeModel _verifyPhoneCodeModel;
  VerifyPhoneCodeModel get verifyPhoneCodeModel => _verifyPhoneCodeModel;

  static late RegisterModel _registerModel;
  RegisterModel get registerModel => _registerModel;

  static Future<LogInModel?> logInService({
    required String credentials,
    required String password,
    required RxBool isLoading,
  }) async {
    Map<String, dynamic> inputBody = {
      'credentials': credentials,
      'password': password,
    };
    return RequestProcess().request<LogInModel>(
      fromJson: LogInModel.fromJson,
      apiEndpoint: ApiEndpoint.login,
      isLoading: isLoading,
      method: HttpMethod.POST,
      body: inputBody,
      isBasic: true,
      onSuccess: (value) {
        _logInModel = value!;
        var data = _logInModel.data;
        LocalStorage.save(
          token: data.token,
          temporaryToken: data.authorization.token,
          isEmailVerified: data.userInfo.emailVerified == 1,
          email: data.userInfo.email,
          kycStatus: data.userInfo.kycVerified,
        );
        if (data.userInfo.emailVerified == 1) {
          if (data.userInfo.twoFactorStatus == 1 &&
              data.userInfo.twoFactorVerified == 0) {
            // Get.toNamed(Routes.);
            LocalStorage.save(
              isLoggedIn: true,
            );
          } else {
            // Get.offAllNamed(Routes.navigation);  //commented by ...
            LocalStorage.save(
              isLoggedIn: true,
            );
          }
        } else {
          Get.toNamed(Routes.registrationEmailVerificationScreen);
        }
      },
    );
  }

//login with phone
  static Future<LoginPhoneModel?> logInPhoneService({
    required RxBool isLoading,
    required String dialCode,
    required String number,
  }) async {
    Map<String, dynamic> inputBody = {
      'otp_country': dialCode,
      'number': number,
    };
    return RequestProcess().request<LoginPhoneModel>(
      fromJson: LoginPhoneModel.fromJson,
      apiEndpoint: ApiEndpoint.loginPhoneCode,
      isLoading: isLoading,
      method: HttpMethod.POST,
      body: inputBody,
      isBasic: true,
      onSuccess: (value) {
        _loginPhoneModel = value!;
        var data = _loginPhoneModel.data;
        LocalStorage.save(
          token: data.token,
          temporaryToken: data.token,
        );
        Get.toNamed(Routes.phoneLoginOtpScreen);
      },
    );
  }

  //login phone verify
  static Future<VerifyPhoneCodeModel?> verifyPhoneOTPProcess({
    required String code,
    required RxBool isLoading,
  }) async {
    Map<String, dynamic> inputBody = {
      'token': LocalStorage.temporaryToken,
      'code': code,
    };

    return RequestProcess().request<VerifyPhoneCodeModel>(
      fromJson: VerifyPhoneCodeModel.fromJson,
      apiEndpoint: ApiEndpoint.verifyPhoneCode,
      isLoading: isLoading,
      method: HttpMethod.POST,
      body: inputBody,
      onSuccess: (value) {
        _verifyPhoneCodeModel = value!;
        LocalStorage.save(userStatus: _verifyPhoneCodeModel.data.userStatus);
        if (_verifyPhoneCodeModel.data.userStatus == 1) {
          Routes.registrationScreen.toNamed;
        } else {
          Routes.navigation.offAllNamed;
        }
      },
    );
  }

  //login phone verify resend
  static Future<CommonSuccessModel?> resendPhoneOTPCode({
    required RxBool isResendLoading,
  }) async {
    return RequestProcess().request<CommonSuccessModel>(
      fromJson: CommonSuccessModel.fromJson,
      apiEndpoint: ApiEndpoint.resendPhoneCode,
      queryParams: {'token': LocalStorage.temporaryToken},
      isLoading: isResendLoading,
      onSuccess: (value) {
        _commonSuccessModel = value!;
      },
    );
  }

  static Future<ForgotPasswordAndVerifyModel?> forgotPasswordProcess({
    required String credentials,
    required RxBool isLoading,
  }) async {
    Map<String, dynamic> inputBody = {'credentials': credentials};
    return RequestProcess().request<ForgotPasswordAndVerifyModel>(
      fromJson: ForgotPasswordAndVerifyModel.fromJson,
      apiEndpoint: ApiEndpoint.forgotPassword,
      isLoading: isLoading,
      method: HttpMethod.POST,
      isBasic: true,
      body: inputBody,
      onSuccess: (value) {
        _forgotPasswordAndVerifyModel = value!;
        var data = _forgotPasswordAndVerifyModel.data;
        LocalStorage.save(
          temporaryToken: data.token,
        );
        Get.toNamed(Routes.forgotPasswordOtpVerificationScreen);
      },
    );
  }

  static Future<CommonSuccessModel?> resendForgotOtpCode({
    required RxBool isResendLoading,
  }) async {
    return RequestProcess().request<CommonSuccessModel>(
      fromJson: CommonSuccessModel.fromJson,
      apiEndpoint: ApiEndpoint.resendForgotOtpCode,
      queryParams: {'token': LocalStorage.temporaryToken},
      isLoading: isResendLoading,
      onSuccess: (value) {
        _commonSuccessModel = value!;
      },
    );
  }

  static Future<ForgotPasswordAndVerifyModel?> otpVerifyProcess({
    required String code,
    required RxBool isLoading,
  }) async {
    Map<String, dynamic> inputBody = {
      'token': LocalStorage.temporaryToken,
      'code': code,
    };

    return RequestProcess().request<ForgotPasswordAndVerifyModel>(
      fromJson: ForgotPasswordAndVerifyModel.fromJson,
      apiEndpoint: ApiEndpoint.forgotPasswordVerifyCode,
      isLoading: isLoading,
      method: HttpMethod.POST,
      body: inputBody,
      onSuccess: (value) {
        _forgotPasswordAndVerifyModel = value!;
        Routes.resetPasswordScreen.toNamed;
      },
    );
  }

  static Future<CommonSuccessModel?> resetPasswordProcess({
    required RxBool isLoading,
    required String password,
    required String confirmPassword,
  }) async {
    Map<String, dynamic> inputBody = {
      'token': LocalStorage.temporaryToken,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    return RequestProcess().request<CommonSuccessModel>(
      fromJson: CommonSuccessModel.fromJson,
      apiEndpoint: ApiEndpoint.resetPassword,
      isLoading: isLoading,
      method: HttpMethod.POST,
      body: inputBody,
      showSuccessMessage: true,
      onSuccess: (value) {
        Get.offNamed(Routes.loginScreen);
      },
    );
  }

  // Register
  static Future<RegisterModel?> registrationProcess({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String userType, // <-- new
    required String verificationStatus,
    required String gstNo,
    required String mobile_code,
    required String mobile,
    required String dialCode,
    required RxBool isLoading,
  }) async {
    Map<String, dynamic> inputBody = {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'password': password,
      'user_type': userType, // <-- send to backend
      'verificationStatus':verificationStatus,
      'gstNo': gstNo,
      'mobile_code': mobile_code,
      'mobile': mobile,
      'otp_country': dialCode,
    };
    return RequestProcess().request<RegisterModel>(
      fromJson: RegisterModel.fromJson,
      apiEndpoint: ApiEndpoint.register,
      isLoading: isLoading,
      method: HttpMethod.POST,
      body: inputBody,
      isBasic: true,
      onSuccess: (value) {
        _registerModel = value!;
        var data = _registerModel.data;
        LocalStorage.save(
          token: data.token,
          temporaryToken: data.authorization.token,
          isLoggedIn: true,
          isKycVerified: data.userInfo.kycVerified == 1,
          isEmailVerified: data.userInfo.emailVerified == 1,
          kycStatus: data.userInfo.kycVerified,
        );
        if (data.userInfo.emailVerified == 1 ||
            LocalStorage.userStatus == "1") {
          // Routes.navigation.offAllNamed; //commented by ....
          LocalStorage.save(isLoggedIn: true);
        } else {
          Get.offAllNamed(Routes.registrationEmailVerificationScreen);
        }
      },
    );
  }

  static Future<CommonSuccessModel?> emailVerifyProcess({
    required String code,
    required RxBool isLoading,
  }) async {
    Map<String, dynamic> inputBody = {
      'token': LocalStorage.temporaryToken,
      'code': code,
    };

    return RequestProcess().request<CommonSuccessModel>(
      fromJson: CommonSuccessModel.fromJson,
      apiEndpoint: ApiEndpoint.emailOtpVerify,
      isLoading: isLoading,
      method: HttpMethod.POST,
      body: inputBody,
      onSuccess: (value) {
        _commonSuccessModel = value!;

        Routes.navigation.offAllNamed;
        LocalStorage.save(isLoggedIn: true);
      },
    );
  }

  static Future<CommonSuccessModel?> resendEmailOtpCode({
    required RxBool isResendLoading,
  }) async {
    return RequestProcess().request<CommonSuccessModel>(
      fromJson: CommonSuccessModel.fromJson,
      apiEndpoint: ApiEndpoint.resendEmailOtp,
      queryParams: {'token': LocalStorage.temporaryToken},
      isLoading: isResendLoading,
      onSuccess: (value) {
        _commonSuccessModel = value!;
      },
    );
  }

  //log login updated

  static Future<GoogleLoginModel> loginWithGoogle(

    String url,
    RxBool isLoading,
  ) async {
    isLoading.value = true;
    // update();
    Map<String, dynamic> inputBody = {
      'token': url,
      'redirect_url':
          '${ApiConfig.mainDomain}/user/social/google/redirect'
    };

    await ApiServicesGoogle.googleLoginProcessApi(body: inputBody)
        .then((value) {
      _googleLoginModel = value!;
      var data = _googleLoginModel.data;

      LocalStorage.save(
        isLoggedIn: true,
        token: data.token,
        temporaryToken: data.authorization.token,
        isEmailVerified: data.userInfo.emailVerified == 1,
        email: data.userInfo.email,
      );

      Get.offAllNamed(Routes.navigation);

      isLoading.value = false;

      // filePathList.clear();
      // update();
    }).catchError((onError) {
      log.e(onError);
    });
    isLoading.value = false;
    // update();
    return _googleLoginModel;
  }

  // Log Out
  static Future<CommonSuccessModel?> logOutService({
    required RxBool isLoading,
  }) async {
    Map<String, dynamic> inputBody = {};
    return RequestProcess().request<CommonSuccessModel>(
      fromJson: CommonSuccessModel.fromJson,
      apiEndpoint: ApiEndpoint.logOut,
      isLoading: isLoading,
      method: HttpMethod.POST,
      body: inputBody,
      onSuccess: (value) {
        _commonSuccessModel = value!;
        Get.offAllNamed(Routes.loginScreen);
        LocalStorage.clear();
      },
    );
  }

  static Future<CommonSuccessModel?> deleteAccountServices({
    required RxBool isLoading,
  }) async {
    Map<String, dynamic> inputBody = {};
    return RequestProcess().request<CommonSuccessModel>(
      fromJson: CommonSuccessModel.fromJson,
      apiEndpoint: ApiEndpoint.deleteAccount,
      isLoading: isLoading,
      method: HttpMethod.POST,
      body: inputBody,
      onSuccess: (value) {
        _commonSuccessModel = value!;
        Get.offAllNamed(Routes.loginScreen);
        LocalStorage.clear();
      },
    );
  }
}
