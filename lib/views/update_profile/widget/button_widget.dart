part of '../screen/update_profile_screen.dart';

class ButtonWidget extends GetView<ProfileController> {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: Dimensions.verticalSize * 0.6,
        top: Dimensions.verticalSize * 0.2,
      ),
      child: Obx(
        () => PrimaryButton(
          title: Strings.update,
          disable: false,
          isLoading: controller.isUpdateLoading,
          onPressed: () {
            controller.updateProfile();
          },
        ),
      ),
    );
  }
}
