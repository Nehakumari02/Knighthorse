part of '../screen/forgot_password_otp_verification_screen.dart';

class OtpHeadingWidget extends GetView<ForgotPinController> {
  const OtpHeadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: Dimensions.heightSize * 0.6, top: Dimensions.heightSize),
      child: Column(
        crossAxisAlignment: crossStart,
        spacing: Dimensions.heightSize * .6,
        children: [
          TextWidget(
            Strings.pleaseEnterOtp,
            fontWeight: FontWeight.bold,
            typographyStyle: TypographyStyle.titleLarge,
          ),
          Row(
            children: [
              TextWidget(
                Strings.weSentCode,
                fontWeight: FontWeight.w400,
                typographyStyle: TypographyStyle.labelMedium,
                colorShade: ColorShade.mediumForty,
              ),
              Flexible(
                child: TextWidget(
                  Get.find<LoginController>().selectedMethodIndex == 0
                      ? controller.emailAddressController.text
                      : controller.phoneNumberController.text,
                  fontWeight: FontWeight.w400,
                  typographyStyle: TypographyStyle.labelMedium,
                  color: CustomColor.blackColor,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
