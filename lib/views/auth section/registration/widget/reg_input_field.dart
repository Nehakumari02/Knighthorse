part of '../screen/registration_screen.dart';

class RegInputField extends GetView<RegistrationController> {
  RegInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: LocalStorage.userStatus == "1",
          child: AbsorbPointer(
            absorbing: true,
            child: PhoneNumberInputField(
                textController: controller.passwordController),
          ),
        ),
        Sizes.height.v10,
        Row(
          children: [
            Expanded(
              child: _inputBoxWidget(
                Strings.firstName,
                Strings.firstName,
                controller.firstNameController,
                removeEnter: true,
              ),
            ),
            Sizes.width.v10,
            Expanded(
              child: _inputBoxWidget(
                Strings.lastName,
                Strings.lastName,
                controller.lastNameController,
                removeEnter: true,
              ),
            ),
          ],
        ),
        Sizes.height.betweenInputBox,
// --- Country, Mobile & Send OTP (Single Row) ---
        Row(
          crossAxisAlignment: CrossAxisAlignment.end, // Aligns button with the bottom of input fields
          children: [
            // 1. Country Code
            Expanded(
              flex: 2,
              child: _inputBoxWidget(
                "Code",
                "+91",
                controller.countryController,
                removeEnter: true,
                textInputType: TextInputType.phone,
              ),
            ),
            Sizes.width.v5, // Smaller gap

            // 2. Mobile Number
            Expanded(
              flex: 5,
              child: _inputBoxWidget(
                "Mobile Number",
                "Number",
                controller.mobileNumberController,
                textInputType: TextInputType.phone,
                removeEnter: true,
              ),
            ),
            Sizes.width.v5, // Smaller gap

            // 3. Send OTP Button
            Expanded(
              flex: 3,
              child: Obx(() {
                // Logic for Button Text
                String buttonText = "Send OTP";
                if (controller.timerCount.value > 0) {
                  buttonText = "Wait ${controller.timerCount.value}s";
                } else if (controller.isOtpSent.value) {
                  buttonText = "Resend";
                }

                return GestureDetector(
                  onTap: () {
                    if (controller.timerCount.value == 0) {
                      controller.sendOtp();
                    }
                  },
                  child: Container(
                    height: 50, // Fixed height to match Input Box height
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.timerCount.value > 0
                          ? Colors.grey
                          : CustomColor.primary,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                    child: TextWidget(
                      buttonText,
                      color: Colors.white,

                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        Sizes.height.betweenInputBox,
// --- OTP Field + Verify Button (Side by Side) ---
        Row(
          crossAxisAlignment: CrossAxisAlignment.end, // Aligns button with input box, not label
          children: [
            Expanded(
              child: _inputBoxWidget(
                "OTP",
                "Enter OTP",
                controller.otpController,
                textInputType: TextInputType.number,
                removeEnter: true, // Helps alignment
              ),
            ),
            Sizes.width.v10,

            // Verify Button
            Obx(() {
              bool isVerified = controller.isOtpVerified.value; // Uses the boolean we added

              return GestureDetector(
                onTap: () {
                  if (!isVerified) {
                    controller.verifyOtp();
                  }
                },
                child: Container(
                  height: 50, // Match height of input box approximately
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSize,
                  ),
                  decoration: BoxDecoration(
                    color: isVerified ? Colors.green : CustomColor.primary,
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                  ),
                  child: isVerified
                      ? Icon(Icons.check, color: Colors.white)
                      : TextWidget(
                    "Verify",
                    color: Colors.white,

                  ),
                ),
              );
            }),
          ],
        ),
        Sizes.height.betweenInputBox,
        Row(
          children: [
            _buildRadioOption(
              title: "Retailer", // You can change this to Strings.retailer
              value: "retailer",
            ),
            Sizes.width.v10, // Add some space between
            _buildRadioOption(
              title: "Wholesaler", // You can change this to Strings.wholesaler
              value: "wholesaler",
            ),
          ],
        ),
        Sizes.height.betweenInputBox,
        _inputBoxWidget(
          Strings.gstNo,
          Strings.gstNo,
          controller.gstNoController,
          // isPasswordField: true,
        ),
        Sizes.height.betweenInputBox,
        _inputBoxWidget(
          Strings.email,
          Strings.email,
          controller.emailAddressController,
        ),
        Sizes.height.betweenInputBox,
        _inputBoxWidget(
          Strings.password,
          Strings.password,
          controller.passwordController,
          isPasswordField: true,
        ),

      ],
    );
  }

  _inputBoxWidget(String label,
      String hintText,
      TextEditingController controller, {
        TextInputType? textInputType,
        bool isPasswordField = false,
        bool isOptional = false,
        bool removeEnter = false,
      }) {
    return PrimaryInputWidget(
      controller: controller,
      label: label,
      hintText: hintText,
      isPasswordField: isPasswordField,
      isOptional: isOptional,
      textInputType: textInputType,
      removeLabelEnter: removeEnter,
    );
  }

  // ... (Keep your existing _inputBoxWidget function here)

  // VVV  ADD THIS MISSING FUNCTION VVV

  Widget _buildRadioOption({required String title, required String value}) {
    return Expanded(
      child: Obx(() { // Obx makes the radio button reactive
        return GestureDetector(
          onTap: () {
            controller.userType.value = value;
          },
          child: Row(
            children: [
              Radio<String>(
                value: value,
                groupValue: controller.userType.value,
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.userType.value = newValue;
                  }
                },
                activeColor: CustomColor.primary, // Optional: style it
              ),
              TextWidget(title), // Uses your existing TextWidget
            ],
          ),
        );
      }),
    );
  }

// ... (Keep your existing _methodSelection and _methodButton functions here)


  _methodSelection() {
    return SizedBox(
      height: Dimensions.heightSize * 4,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(Get
            .find<LoginController>()
            .loginMethod
            .length,
                (index) {
              return _methodButton(index);
            }),
      ),
    );
  }

  _methodButton(int index) {
    var data = Get
        .find<LoginController>()
        .loginMethod[index];
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
              height: 3,
              width: 30,
              color: isSelected ? CustomColor.primary : Colors.transparent,
            )
          ],
        ),
      );
    }));
  }
}