part of '../screen/login_screen.dart';

class OtherLoginOption extends GetView<LoginController> {
  const OtherLoginOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.verticalSize * .5),
      child: Column(
        children: [_dividerSection(), _otherOptions()],
      ),
    );
  }

  _dividerSection() {
    return SizedBox(
      height: Dimensions.heightSize * 4,
      child: Row(
        children: [
          Expanded(
              child: DividerWidget(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.horizontalSize * 0.42,
            ),
          )),
          TextWidget(Strings.or),
          Expanded(
              child: DividerWidget(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.horizontalSize * 0.42,
            ),
          ))
        ],
      ),
    );
  }

  _otherOptions() {
    return InkWell(
      onTap: () {
        controller.onGoogleLogin();
        // print("Google login tapped");
      },
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(
          controller.otherLoginMethod.length,
          (index) => _otherOptionsButton(index),
        ),
      ),
    );
  }

  _otherOptionsButton(int index) {
    var data = controller.otherLoginMethod[index];
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.2)),
      child: Row(
        mainAxisAlignment: mainCenter,
        children: [
          Container(
            height: Dimensions.heightSize * 5,
            width: Dimensions.widthSize * 5,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.horizontalSize * .5,
              vertical: Dimensions.verticalSize * .5,
            ),
            decoration:
                BoxDecoration(image: DecorationImage(image: AssetImage(data))),
          ),
          Sizes.width.v10,
          TextWidget(Strings.loginWithGoogle),
        ],
      ),
    );
  }
}
