part of '../screen/reset_password_screen.dart';

class ResetPasswordHeading extends GetView<ResetPasswordController> {
  const ResetPasswordHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: Dimensions.heightSize * 0.6, top: Dimensions.heightSize),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          TextWidget(
            Strings.passwordReset,
            style: CustomStyle.titleLarge.copyWith(
              fontSize: Dimensions.titleLarge * 0.9,
            ),
          ),
          Sizes.height.v5,
          TextWidget(
            Strings.resetYourPassword,
            fontWeight: FontWeight.w400,
            typographyStyle: TypographyStyle.labelMedium,
            padding: EdgeInsets.only(right: Dimensions.horizontalSize * 1.95),
          ),
        ],
      ),
    );
  }
}
