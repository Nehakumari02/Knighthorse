part of 'change_password_screen.dart';

class ChangePasswordMobileScreen extends GetView<ChangePasswordController> {
  const ChangePasswordMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(Strings.changePassword),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize * 0.7,
        ),
        child: ListView(
          children: [
            Sizes.height.betweenInputBox,
            PrimaryInputWidget(
              controller: controller.oldPasswordController,
              label: Strings.oldPassword,
              hintText: Strings.oldPassword,
              textInputType: TextInputType.visiblePassword,
              showBorderSide: true,
              isPasswordField: true,
              outerLabel: true,
            ),
            Sizes.height.betweenInputBox,
            PrimaryInputWidget(
              controller: controller.newPasswordController,
              label: Strings.newPassword,
              hintText: Strings.newPassword,
              textInputType: TextInputType.visiblePassword,
              showBorderSide: true,
              isPasswordField: true,
              outerLabel: true,
            ),
            Sizes.height.betweenInputBox,
            PrimaryInputWidget(
              controller: controller.confirmPasswordController,
              label: Strings.confirmPassword,
              hintText: Strings.confirmPassword,
              textInputType: TextInputType.visiblePassword,
              showBorderSide: true,
              isPasswordField: true,
              outerLabel: true,
            ),
            Sizes.height.v25,
            Obx(
              () => PrimaryButton(
                isLoading: controller.isLoading,
                disable: !controller.isFormValid.value,
                title: Strings.changePassword,
                onPressed: () {
                  if (controller.isFormValid.value) {
                    controller.changePasswordProcess();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
