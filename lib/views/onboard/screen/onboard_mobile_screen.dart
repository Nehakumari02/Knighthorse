part of 'onboard_screen.dart';

class OnboardMobileScreen extends GetView<OnboardController> {
  const OnboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _clipViewWidget(context),
          Obx(
            () => Align(
              alignment: controller.selectedIndex.value == 0
                  ? Alignment.center
                  : Alignment.topCenter,
              child: _otherWidget(context),
            ),
          )
        ],
      ),
    );
  }

  _otherWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.horizontalSize * 0.8,
        right: Dimensions.horizontalSize * 0.8,
        top: controller.selectedIndex.value == 0
            ? 0
            : Dimensions.verticalSize * 5,
      ),
      child: Column(
        mainAxisSize: mainMin,
        crossAxisAlignment: crossCenter,
        mainAxisAlignment: mainCenter,
        children: [
          _contentWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _clipViewWidget(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView.builder(
          controller: controller.pageController,
          itemCount: BasicServices.onboardScreen.length,
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              height: MediaQuery.of(context).size.height,
              imageUrl:
                  "${BasicServices.basePath.value}/${BasicServices.appPathLocation.value}/${BasicServices.onboardScreen[index].image}",
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => Container(),
              fit: BoxFit.cover,
            );
          },
          onPageChanged: (v) {
            controller.selectedIndex.value = v;
          },
        ),
      ],
    );
  }

  _indicatorWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: mainCenter,
      children: List.generate(
        // BasicServices.onboardScreen.length,
        2,
        (index) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: Dimensions.horizontalSize * 0.15,
          ),
          height: index == controller.selectedIndex.value
              ? Dimensions.heightSize * 2.5
              : Dimensions.heightSize * 1.8,
          alignment: Alignment.center,
          width: Dimensions.widthSize * 0.6,
          decoration: BoxDecoration(
            color: index == controller.selectedIndex.value
                ? CustomColor.primary
                : CustomColor.primary.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  _contentWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalSize * .6),
      child: Column(
        crossAxisAlignment: crossCenter,
        children: [
          TextWidget(
            BasicServices.onboardScreen[controller.selectedIndex.value].title,
            style: CustomStyle.titleLarge.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: GoogleFonts.outfit().fontFamily),
            textAlign: TextAlign.center,
          ),
          TextWidget(
            BasicServices
                .onboardScreen[controller.selectedIndex.value].subTitle,
            typographyStyle: TypographyStyle.titleSmall,
            style: CustomStyle.titleSmall.copyWith(
                fontWeight: FontWeight.w400,
                fontFamily: GoogleFonts.outfit().fontFamily),
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.verticalSize * 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.verticalSize * .7,
      ),
      child: Row(
        mainAxisAlignment: mainCenter,
        children: [
          _next(),
        ],
      ),
    );
  }

  _skip() {
    return GestureDetector(
      onTap: () {
        LocalStorage.save(onboardSave: true);
        Get.offAllNamed(Routes.loginScreen);
      },
      child: TextWidget(
        Strings.skip,
        typographyStyle: TypographyStyle.labelLarge,
      ),
    );
  }

  _next() {
    return GestureDetector(
      onTap: () {
        final currentPage = controller.selectedIndex.value;
        if (currentPage < BasicServices.onboardScreen.length - 1) {
          controller.pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          LocalStorage.save(onboardSave: true);
          // Get.offAllNamed(Routes.loginScreen);
          Get.offAllNamed(Routes.navigation);
          print("Onboard Completed");
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize * 0.6,
          vertical: Dimensions.verticalSize * 0.5,
        ),
        decoration: BoxDecoration(
          color: CustomColor.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}
