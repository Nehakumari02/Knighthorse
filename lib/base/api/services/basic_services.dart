import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../views/auth section/auth_model/basic_settings_model.dart';
import '../../themes/model.dart';
import '../../utils/basic_import.dart';
import '../endpoint/api_endpoint.dart';
import '../method/request_process.dart';

class BasicServices {
  // Basic Info
  static final List<UserOnboardScreen> onboardScreen = [];
  static RxString splashImage = ''.obs;
  static RxString appBasicLogoWhite = ''.obs;
  static RxString appBasicLogoDark = ''.obs;
  static RxString appLogoFavDark = ''.obs;
  static RxString appLogoFav = ''.obs;
  static RxString appLauncher = ''.obs;
  static RxString privacyPolicy = ''.obs;
  static RxString contactUs = ''.obs;
  static RxString aboutUs = ''.obs;
  static RxString basePath = ''.obs;
  static RxString defaultImage = ''.obs;
  static RxString pathLocation = ''.obs;
  static RxString appPathLocation = ''.obs;
  static RxString productPathLocation = ''.obs;
  static RxString siteName = ''.obs;
  static RxString siteTitle = ''.obs;
  static RxInt userRegistration = (1).obs;
  static RxInt agreePolicy = (1).obs;
  static RxString baseColor = ''.obs;
  static RxString secondaryColor = ''.obs;
  static Rxn<BaseCur> baseCurrency = Rxn<BaseCur>();
  static final _isLoading = false.obs;
  static bool get isLoading => _isLoading.value;
  static late BasicSettingsModel _basicSettingsModel;
  static BasicSettingsModel get basicSettingsModel => _basicSettingsModel;

  static Future<BasicSettingsModel?> getBasicSettingsInfo() async {
    return RequestProcess().request<BasicSettingsModel>(
      fromJson: BasicSettingsModel.fromJson,
      apiEndpoint: ApiEndpoint.basicSettings,
      isLoading: _isLoading,
      showSuccessMessage: false,
      onSuccess: (value) {
        _basicSettingsModel = value!;
        onboardScreen.clear();
        basePath.value = _basicSettingsModel.data.imagePaths.basePath;
        defaultImage.value = _basicSettingsModel.data.imagePaths.defaultImage;
        baseCurrency.value = _basicSettingsModel.data.baseCur;
        pathLocation.value =
            _basicSettingsModel.data.appImagePaths.pathLocation;
        appPathLocation.value =
            _basicSettingsModel.data.appImagePaths.pathLocation;
        productPathLocation.value =
            _basicSettingsModel.data.imagePaths.productImage;
        var splash = _basicSettingsModel.data.splashScreen.splashScreenImage;
        // splash
        splashImage.value =
            "${basePath.value}/${appPathLocation.value}/$splash";
        // onboard
        for (var element in _basicSettingsModel.data.userOnboardScreens) {
          onboardScreen.add(
            UserOnboardScreen(
                id: element.id,
                title: element.title,
                image: element.image,
                status: element.status,
                subTitle: element.subTitle),
          );
        }

        // Site Logo
        var imagePaths = _basicSettingsModel.data.imagePaths;
        var siteLogo = _basicSettingsModel.data.basicSettings.siteLogo;
        var siteLogoDark = _basicSettingsModel.data.basicSettings.siteLogoDark;
        baseColor.value = _basicSettingsModel.data.basicSettings.baseColor;
        secondaryColor.value =
            _basicSettingsModel.data.basicSettings.secondaryColor;
        siteName.value = _basicSettingsModel.data.basicSettings.siteName;
        siteTitle.value = _basicSettingsModel.data.basicSettings.siteTitle;
        userRegistration.value =
            _basicSettingsModel.data.basicSettings.userRegistration;
        agreePolicy.value = _basicSettingsModel.data.basicSettings.agreePolicy;

        appBasicLogoWhite.value =
            '${imagePaths.basePath}/${imagePaths.pathLocation}/${siteLogo}';
        appBasicLogoDark.value =
            '${imagePaths.basePath}/${imagePaths.pathLocation}/${siteLogoDark}';
        appLauncher.value =
            '${imagePaths.basePath}/${imagePaths.pathLocation}/${siteLogo}';

        Strings.appName = siteName.value;
        CustomColor.primary = HexColor(secondaryColor.value);
        CustomColor.secondary = HexColor(baseColor.value);

        debugPrint("product location ${productPathLocation.value}");
      },
    );
  }
}

// https://mishkatul.appdevs.team/knighthorse/public/backend/images/web-settings/image-assets/5436549a-74e7-4cde-b04f-1b9bc4e28880.webp
