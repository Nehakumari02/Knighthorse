part of '../screen/order_details_screen.dart';

class DelivaryInfo extends GetView<OrderDetailsController> {
  const DelivaryInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _detailsInputField();
  }

  _detailsInputField() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: Dimensions.verticalSize * 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius * 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalSize,
          vertical: Dimensions.verticalSize * .8,
        ),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            TextWidget(
              Strings.deliveryInfo,
              fontSize: Dimensions.titleMedium * 1.25,
              fontWeight: FontWeight.w500,
            ),
            DividerWidget(),
            _inputField(controller.phoneController, "", Strings.phoneNumber),
            Sizes.height.betweenInputBox,
            _inputField(controller.emailController, "", Strings.email),
            Sizes.height.betweenInputBox,
            _inputField(controller.addressController, Strings.addressHintText,
                Strings.address,
                maxLines: 2),
            if (controller.orderNoteController.text.isNotEmpty)
              Column(
                children: [
                  Sizes.height.betweenInputBox,
                  _inputField(controller.orderNoteController,
                      Strings.orderNotesHintText, Strings.orderNotes,
                      maxLines: 2),
                ],
              ),
          ],
        ),
      ),
    );
  }

  _inputField(
    TextEditingController controller,
    String hintText,
    String labelText, {
    int maxLines = 1,
  }) {
    return PrimaryInputWidget(
      controller: controller,
      hintText: hintText,
      label: labelText,
      maxLines: maxLines,
      fontStyle: CustomStyle.labelLarge,
      outerLabel: true,
      readOnly: true,
    );
  }
}
