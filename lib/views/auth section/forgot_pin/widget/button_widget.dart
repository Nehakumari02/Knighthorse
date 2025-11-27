part of '../screen/forgot_pin_screen.dart';

class ButtonWidget extends GetView<ForgotPinController> {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.verticalSize),
      child: Column(
        mainAxisSize: mainMin,
        children: [
          Obx(
            () => PrimaryButton(
              title: Strings.sendOTP,
              disable: !controller.isFormValid.value,
              isLoading: controller.isLoading,
              onPressed: () {
                if (controller.isFormValid.value) {
                  controller.onForgotPassword;
                }
              },
            ),
          ),
          Sizes.height.betweenInputBox,
          LoginWithPassword()
        ],
      ),
    );
  }
}
