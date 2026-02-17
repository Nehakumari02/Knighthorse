part of '../screen/login_screen.dart';

class InputField extends GetView<LoginController> {
  const InputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.verticalSize * .5),
      child: Column(
        children: [
          // _methodSelection(),
          _inputField(),
          _isforgotPin(context),
        ],
      ),
    );
  }

  _methodSelection() {
    return SizedBox(
      height: Dimensions.heightSize * 4,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(controller.loginMethod.length, (index) {
          return _methodButton(index);
        }),
      ),
    );
  }

  _methodButton(int index) {
    var data = controller.loginMethod[index];
    return GestureDetector(onTap: () {
      controller.selectedMethodIndex.value = index;
    }, child: Obx(() {
      bool isSelected = controller.selectedMethodIndex.value == index;
      return Padding(
        padding: EdgeInsets.only(right: Dimensions.horizontalSize),
        child: Column(
          children: [
            TextWidget(
              data,
              typographyStyle: TypographyStyle.titleSmall,
              color: isSelected
                  ? CustomColor.primary
                  : CustomColor.typographyShade[40],
            ),
            Sizes.height.v5,
            Container(
              height: Dimensions.heightSize * .3,
              width: Dimensions.widthSize * 3,
              color: isSelected ? CustomColor.primary : Colors.transparent,
            )
          ],
        ),
      );
    }));
  }

  _inputField() {
    return Obx(
      () => Column(
        children: [
          controller.selectedMethodIndex.value == 0
              ? _inputBox(controller.emailAddressController,
                  Strings.emailAddress, Strings.emailAddress)
              : PhoneNumberInputField(
                  textController: controller.phoneNumberController,
                  onChanged: (v) {
                    controller.selectCountry.value = v;
                    controller.dialCode.value = v.countryCode;
                    controller.dialCode.value = v.countryCode;
                    LocalStorage.save(dialCode: controller.dialCode.value);
                    controller.phoneNumberController.text = v.nsn;
                  },
                ),
          Sizes.height.betweenInputBox,
          if (controller.selectedMethodIndex.value == 0)
            _inputBox(controller.passwordController, Strings.password,
                Strings.password,
                isPassword: true)
        ],
      ),
    );
  }

  _inputBox(TextEditingController controller, String hintText, String labelText,
      {bool? isPassword = false}) {
    return PrimaryInputWidget(
      controller: controller,
      hintText: hintText,
      label: labelText,
      isPasswordField: isPassword!,
    );
  }

  _isforgotPin(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.selectedMethodIndex.value == 0,
        child: Container(
          margin: EdgeInsets.only(top: Dimensions.heightSize * 0.85),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.forgotPinScreen);
                },
                child: TextWidget(
                  Strings.forgotPassword,
                  fontWeight: FontWeight.w400,
                  color: CustomColor.primary,
                  typographyStyle: TypographyStyle.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
