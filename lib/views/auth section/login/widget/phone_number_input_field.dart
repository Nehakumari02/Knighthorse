part of '../screen/login_screen.dart';

class PhoneNumberInputField extends GetView<LoginController> {
  const PhoneNumberInputField({
    super.key,
    required this.textController,
    this.suffixIcon,
    this.suffixIconPadding,
    this.readOnly = false,
    this.onChanged,
    this.countryCode,
  });
  final TextEditingController textController;
  final Widget? suffixIcon;
  final EdgeInsets? suffixIconPadding;
  final String? countryCode;
  final bool readOnly;

  final Function(PhoneNumber)? onChanged;

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    return PrimaryPhoneFormField(
      readOnly: readOnly,
      showDialCode: false,
      controller: textController,
      label: Strings.phoneNumber,
      hintText: Strings.phoneNumber,
      textInputType: TextInputType.number,
      suffixIcon: suffixIcon,
      countryCode: countryCode,
      suffixIconPadding: suffixIconPadding,
      onChanged: onChanged,
    );
  }
}
