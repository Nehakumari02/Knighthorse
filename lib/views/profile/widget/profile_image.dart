part of '../screen/profile_screen.dart';

class ProfileImagePicker extends GetView<ProfileController> {
  ProfileImagePicker({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 10,
            color: CustomColor.background,
          ),
        ),
        child: Obx(
          () => LocalStorage.isLoggedIn
              ? controller.isLoading
                  ? Shimmer.fromColors(
                      baseColor:
                          CustomColor.disableColor.withValues(alpha: 0.3),
                      highlightColor: Colors.grey.shade100,
                      child: CircleAvatar(
                        radius: Dimensions.radius * 3,
                        backgroundColor: CustomColor.disableColor,
                      ))
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: CustomColor.primary,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: CustomColor.background,
                        backgroundImage: NetworkImage(
                          LocalStorage.isLoggedIn
                              ? controller.userImage.value
                              : controller.guestImage.value,
                        ),
                        radius: Dimensions.radius * 5,
                      ),
                    )
              : Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: CustomColor.primary,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: CustomColor.background,
                    backgroundImage: NetworkImage(
                      controller.guestImage.value,
                    ),
                    radius: Dimensions.radius * 5,
                  ),
                ),
        ),
      ),
    );
  }
}
