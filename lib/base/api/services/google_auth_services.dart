import 'package:knighthorse/base/api/endpoint/api_endpoint.dart';
import 'package:http/http.dart' as http;

import '../../../views/auth section/login/model/google_login_model.dart';
import '../../utils/basic_import.dart';
import '../method/google_method.dart' as ga;

class ApiServicesGoogle {
  static var client = http.Client();

  //Google Login

  static Future<GoogleLoginModel?> googleLoginProcessApi({
    required Map<String, dynamic> body,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ga.ApiMethodGoogle().post(
        '${ApiConfig.baseUrl}/user/social/auth/redirect/response/google',
        body,
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        GoogleLoginModel result = GoogleLoginModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      ga.log.e('🐞🐞🐞 err from Sign in api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in SignInModel');
      return null;
    }
    return null;
  }
}
