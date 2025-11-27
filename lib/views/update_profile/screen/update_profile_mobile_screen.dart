part of 'update_profile_screen.dart';

class UpdateProfileMobileScreen extends GetView<ProfileController> {
  const UpdateProfileMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(Strings.updateProfile),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize * .8,
        ),
        children: [
          ProfilePicturePicker(),
          UserAndEmailWidget(),
          InputFieldWidget(),
          ButtonWidget()
        ],
      ),
    );
  }
}
