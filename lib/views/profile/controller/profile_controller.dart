import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../base/utils/basic_import.dart';
import '../../../base/api/endpoint/api_endpoint.dart';
import '../../../base/api/method/request_process.dart';
import '../../../base/api/model/common_success_model.dart';
import '../../../base/api/services/basic_services.dart';
import '../../../base/utils/local_storage.dart';
import '../../update_profile/model/profile_info_model.dart';

class ProfileController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  var baseCurrencyFlag = "https://flagcdn.com/w320/us.png".obs;
  var walletBalance = "".obs;
  var walletCurrency = BasicServices.baseCurrency.value!.code.obs;
  var walletCurrencyName = "".obs;
  var countryDialCode = "".obs;
  final formKey = GlobalKey<FormState>();
  RxBool isFormValid = false.obs;
  RxString userImage = ''.obs;
  RxString guestImage = "${BasicServices.basePath.value}/${BasicServices.defaultImage}".obs;
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxBool isAvailableUserImage = false.obs;
  RxString countrySelectMethod = ''.obs;
  List<String> genderList = [Strings.male, Strings.female];
  RxString selectedGender = Strings.male.obs;
  RxString selectedDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    firstNameController.addListener(_updateFormValidity);
    lastNameController.addListener(_updateFormValidity);
    if (LocalStorage.isLoggedIn) getProfileInfo();
  }

  void _updateFormValidity() {
    isFormValid.value = firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty;
  }

  // Get Profile Info
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late ProfileInfoModel _profileInfoModel;
  ProfileInfoModel get profileInfoModel => _profileInfoModel;

  Future<ProfileInfoModel?> getProfileInfo() async {
    return RequestProcess().request<ProfileInfoModel>(
      fromJson: ProfileInfoModel.fromJson,
      apiEndpoint: ApiEndpoint.profileInfo,
      isLoading: _isLoading,
      onSuccess: (value) {
        _profileInfoModel = value!;
        _setProfileData();
      },
    );
  }

  void _setProfileData() {
    var userInfo = _profileInfoModel.data.userInfo;
    var imagePaths = _profileInfoModel.data.imagePaths;
    firstNameController.text = userInfo.firstname;
    lastNameController.text = userInfo.lastname;
    emailController.text = userInfo.email;
    addressController.text = userInfo.address;

    userName.value = '${userInfo.firstname} ${userInfo.lastname}';
    userEmail.value = userInfo.email;
    walletBalance.value = _profileInfoModel.data.userWallet?.balance ?? "0.00";
    countryDialCode.value = userInfo.mobileCode;
    phoneNumberController.text = "${countryDialCode.value}${userInfo.mobile}";
    LocalStorage.save(email: userInfo.email);

    if (userInfo.image != '') {
      userImage.value =
          "${imagePaths.baseUrl}/${imagePaths.pathLocation}/${userInfo.image}";

      isAvailableUserImage.value = true;
    } else {
      userImage.value = "${imagePaths.baseUrl}/${imagePaths.defaultImage}";
    }
  }

  // Profile Update
  final _isUpdateLoading = false.obs;
  bool get isUpdateLoading => _isUpdateLoading.value;

  late CommonSuccessModel _commonSuccessModel;
  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  Future<CommonSuccessModel?> updateProfile() async {
    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'phone': phoneNumberController.text,
      'address': addressController.text,
      'otp_country': countryDialCode.value,
    };

    return RequestProcess().request<CommonSuccessModel>(
      fromJson: CommonSuccessModel.fromJson,
      apiEndpoint: ApiEndpoint.updateProfile,
      isLoading: _isUpdateLoading,
      method: HttpMethod.POST,
      fieldList: isImagePathSet.value ? ['image'] : null,
      pathList: isImagePathSet.value ? [imagePath.value] : null,
      body: inputBody,
      showSuccessMessage: true,
      onSuccess: (value) {
        _commonSuccessModel = value!;
        getProfileInfo();
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    firstNameController.removeListener(_updateFormValidity);
    lastNameController.removeListener(_updateFormValidity);
    phoneNumberController.removeListener(_updateFormValidity);
  }

  // Set Image
  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();
  var isImagePathSet = false.obs;
  var imagePath = "".obs;

  void setImagePath(String path) {
    imagePath.value = path;
    isImagePathSet.value = true;
  }

  // image picker function
  Future pickImage(imageSource) async {
    try {
      final image = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 40, // define image quality
        maxHeight: 600, // image height
        maxWidth: 600, // image width
      );
      if (image == null) return;
      pickedFile = File(image.path);
      setImagePath(pickedFile!.path);
    } on PlatformException catch (e) {
      CustomSnackBar.error('Error: $e');
    }
  }
}


// https://mishkatul.appdevs.team/knighthorse/public/backend/images/default/profile-default.webp