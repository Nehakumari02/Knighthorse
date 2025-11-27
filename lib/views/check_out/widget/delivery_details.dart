part of '../screen/check_out_screen.dart';

class DeliveryDetails extends GetView<CartController> {
  const DeliveryDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        OrderDetails(),
        Sizes.height.v10,
        TextWidget(
          Strings.deliveryDetails,
          typographyStyle: TypographyStyle.titleMedium,
          fontWeight: FontWeight.w500,
        ),
        Sizes.height.v10,
        ShipmentWidget(),
        Sizes.height.v10,
        _detailsInputField()
      ],
    );
  }

  _detailsInputField() {
    return Column(
      children: [
        _inputField(controller.phoneController, Strings.phoneNumber,
            Strings.phoneNumber,
            textInputType: TextInputType.number),
        Sizes.height.betweenInputBox,
        _inputField(controller.emailController, Strings.email, Strings.email, readOnly:Get.find<ProfileController>().userEmail.value.isNotEmpty? true : false),
        Sizes.height.betweenInputBox,
        _inputField(controller.addressController, Strings.addressHintText,
            Strings.address,
            maxLines: 3),
        Sizes.height.betweenInputBox,
        _inputField(controller.orderNoteController, Strings.orderNotesHintText,
            Strings.orderNotes,
            maxLines: 3),
      ],
    );
  }

  _inputField(
      TextEditingController controller, String hintText, String labelText,
      {int maxLines = 1, TextInputType? textInputType, bool? readOnly}) {
    return PrimaryInputWidget(
      controller: controller,
      hintText: hintText,
      label: labelText,
      maxLines: maxLines,
      readOnly: readOnly ?? false,
      // outerLabel: true,
      textInputType: textInputType,
    );
  }
}
