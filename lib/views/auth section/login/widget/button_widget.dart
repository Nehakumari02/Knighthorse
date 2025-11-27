part of '../screen/login_screen.dart';

class ButtonWidget extends GetView<LoginController> {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.verticalSize * .6),
      child: Obx(
        () => PrimaryButton(
          isLoading: controller.isLoading,
          disable: !controller.isFormValid.value,
          title: controller.selectedMethodIndex.value == 0
              ? Strings.logIn
              : Strings.sendOTP,
          onPressed: () {
            if (controller.isFormValid.value) {
              controller.onLogInProcess;
            }
          },
        ),
      ),
    );
  }
}
