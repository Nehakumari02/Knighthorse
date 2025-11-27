part of 'phone_login_otp_screen.dart';

class PhoneLoginOtpMobileScreen extends GetView<PhoneLoginOtpController> {
  const PhoneLoginOtpMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(''),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize,
          vertical: Dimensions.verticalSize * .2,
        ),
        children: [
          BrandLogo(),
          HeadingWidget(),
          LoginOtpWidget(),
          TimerWidget(
            onResendCode: () {
              controller.onResendOtp;
            },
          ),
          Obx(
            () => PrimaryButton(
              title: Strings.submit,
              disable: !controller.isFormValid.value,
              isLoading: controller.isLoading,
              onPressed: () {
                if (controller.isFormValid.value) {
                  controller.onOtpSubmit;
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
