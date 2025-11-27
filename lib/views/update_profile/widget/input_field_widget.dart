part of '../screen/update_profile_screen.dart';

class InputFieldWidget extends GetView<ProfileController> {
  const InputFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: PrimaryInputWidget(
                  controller: controller.firstNameController,
                  hintText: Strings.firstName,
                  label: Strings.firstName,
                  removeLabelEnter: true,
                )),
                Sizes.width.v10,
                Expanded(
                  child: PrimaryInputWidget(
                    controller: controller.lastNameController,
                    hintText: Strings.lastName,
                    label: Strings.lastName,
                    removeLabelEnter: true,
                  ),
                ),
              ],
            ),
            Sizes.height.betweenInputBox,
            PrimaryInputWidget(
              readOnly: true,
              controller: controller.emailController,
              hintText: Strings.emailAddress,
              label: Strings.emailAddress,
            ),
            Sizes.height.betweenInputBox,
            PhoneNumberInputField(
              textController: controller.phoneNumberController,
              countryCode: controller.countryDialCode.value,
              onChanged: (v) {
                controller.phoneNumberController.text = v.nsn;
                controller.countryDialCode.value = v.countryCode;
                debugPrint(v.isoCode.toString());
                debugPrint("+${v.countryCode}${v.nsn}");
              },
            ),
            Sizes.height.betweenInputBox,
            PrimaryInputWidget(
              controller: controller.addressController,
              hintText: Strings.addressNotes,
              label: Strings.yourAddress,
              maxLines: 4,
            ),
          ],
        ));
  }
}
