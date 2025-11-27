part of '../screen/forgot_pin_screen.dart';

class ForgotInputField extends GetView<ForgotPinController> {
  const ForgotInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.verticalSize * .8),
      child: Obx(
        () => Column(
          children: [
            Get.find<LoginController>().selectedMethodIndex.value == 0
                ? _inputBox(controller.emailAddressController, Strings.emailAddress,
                    Strings.emailAddress)
                : PhoneNumberInputField(
                    textController: controller.phoneNumberController),
          ],
        ),
      ),
    );
  }

  _inputBox(
      TextEditingController controller, String hintText, String labelText) {
    return PrimaryInputWidget(
      controller: controller,
      hintText: hintText,
      label: labelText,
      removeLabelEnter: true,
    );
  }
}
