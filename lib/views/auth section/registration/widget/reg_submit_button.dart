part of '../screen/registration_screen.dart';

class RegSubmitButton extends GetView<RegistrationController> {
  const RegSubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: Dimensions.verticalSize.edgeVertical * 0.7,
        child: PrimaryButton(
          disable: !controller.isFormValid.value,
          title: Strings.registerNow,
          isLoading: controller.isLoading,
          onPressed: () {
            if (controller.isFormValid.value) {
              controller.onRegistration;
            }
          },
        ),
      ),
    );
  }
}
