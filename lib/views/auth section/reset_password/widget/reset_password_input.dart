part of '../screen/reset_password_screen.dart';

class ResetPasswordInput extends GetView<ResetPasswordController> {
  const ResetPasswordInput({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.verticalSize * .8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryInputWidget(
            controller: controller.newPasswordController,
            label: Strings.password,
            hintText: Strings.password,
            isPasswordField: true,
          ),
          Sizes.height.betweenInputBox,
          PrimaryInputWidget(
            controller: controller.confirmPasswordController,
            label: Strings.confirmPassword,
            hintText: Strings.confirmPassword,
            isPasswordField: true,
          ),
        ],
      ),
    );
  }
}
