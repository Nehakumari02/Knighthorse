part of '../screen/reg_email_verification_screen.dart';

class OtpHeading extends GetView<RegistrationController> {
  const OtpHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: Dimensions.heightSize * 0.6, top: Dimensions.heightSize),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          TextWidget(
            Strings.pleaseEnterOtp,
            style: CustomStyle.titleLarge.copyWith(
              fontSize: Dimensions.titleLarge * 0.9,
            ),
          ),
          Sizes.height.v5,
          Row(
            children: [
              TextWidget(
                Strings.weSentCode,
                fontWeight: FontWeight.w400,
                typographyStyle: TypographyStyle.labelMedium,
                colorShade: ColorShade.mediumForty,
              ),
              TextWidget(
                controller.emailAddressController.text,
                fontWeight: FontWeight.w400,
                typographyStyle: TypographyStyle.labelMedium,
                color: CustomColor.primary,
                padding:
                    EdgeInsets.only(right: Dimensions.horizontalSize * 1.95),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
