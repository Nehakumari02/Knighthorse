part of '../screen/dashboard_screen.dart';

class PromotionCarouselWidget extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.verticalSize * 0.5,
        top: Dimensions.verticalSize * 0.5,
      ),
      child: Column(
        mainAxisSize: mainMin,
        children: [
          CarouselSlider.builder(
            itemCount: controller.bannerImages.length,
            itemBuilder: (context, index, realIndex) {
              var data = controller.bannerImages[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radius),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                        "${controller.imagePath.value}${data.image}"),
                    fit: BoxFit.fill,
                  )),
                ),
              );
            },
            options: CarouselOptions(
              height: Dimensions.buttonHeight * 1.5,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 16 / 7,
              autoPlayInterval: Duration(seconds: 3),
              onPageChanged: (index, reason) {
                controller.bannerImageIndex.value = index;
              },
            ),
          ),
          _indicaorWidget(),
        ],
      ),
    );
  }

  _indicaorWidget() {
    return Obx(() => Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            DotsIndicator(
              dotsCount: controller.bannerImages.length,
              position: controller.bannerImageIndex.value.toDouble(),
              decorator: DotsDecorator(
                activeColor: CustomColor.primary,
                color: CustomColor.disableColor,
                size:
                    Size(Dimensions.heightSize * .6, Dimensions.widthSize * .6),
                activeSize:
                    Size(Dimensions.heightSize * .6, Dimensions.widthSize * .6),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * .5),
                ),
              ),
            )
          ]),
        ));
  }
}
