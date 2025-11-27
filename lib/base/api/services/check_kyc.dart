// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../routes/routes.dart';
// import '../../../views/auth/kyc_information/controller/kyc_information_controller.dart';
// import '../../utils/basic_import.dart';

// checkKycStatus({required VoidCallback onSuccess}) {
//   final kycController = Get.put(KycInformationController());
//   if (kycController.kycStatus.value == 1) {
//     onSuccess();
//   } else {
//     CustomSnackBar.error(Strings.pleaseVerifyYourKycInfo);
//     Get.toNamed(Routes.kycInformationScreen);
//   }
// }
