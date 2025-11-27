part of '../screen/profile_screen.dart';

class UserAndEmailWidget extends GetView<ProfileController> {
  const UserAndEmailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocalStorage.isLoggedIn
            ? Column(
                children: [
                  Obx(
                    () => controller.isLoading
                        ? Shimmer.fromColors(
                            baseColor:
                                CustomColor.disableColor.withValues(alpha: 0.3),
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: Dimensions.heightSize,
                              width: 100.w,
                              color: CustomColor.disableColor
                                  .withValues(alpha: 0.3),
                            ),
                          )
                        : TextWidget(
                            controller.userName.value,
                            typographyStyle: TypographyStyle.headlineSmall,
                          ),
                  ),
                  Obx(
                    () => controller.isLoading
                        ? Shimmer.fromColors(
                            baseColor:
                                CustomColor.disableColor.withValues(alpha: 0.3),
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: Dimensions.heightSize,
                              width: 100.w,
                              color: CustomColor.disableColor
                                  .withValues(alpha: 0.3),
                            ),
                          )
                        : TextWidget(
                            controller.userEmail.value,
                            typographyStyle: TypographyStyle.bodySmall,
                          ),
                  ),
                  Sizes.height.v10,
                ],
              )
            : Column(
                children: [
                  TextWidget(
                    Strings.guestUser,
                    typographyStyle: TypographyStyle.headlineSmall,
                  ),
                  TextWidget(
                    Strings.pleaseLogInToContinue,
                    typographyStyle: TypographyStyle.bodySmall,
                  ),
                  Sizes.height.v10,
                ],
              )
      ],
    );
  }
}
