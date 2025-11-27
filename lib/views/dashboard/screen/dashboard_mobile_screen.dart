part of 'dashboard_screen.dart';

class DashboardMobileScreen extends GetView<DashboardController> {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBarWidget(),
        body: Obx(() => controller.isBannerOfferLoading ||
                controller.isPopularLoading ||
                controller.specialProductLoading
            ? Loader()
            : _bodyWidget(context)));
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        PromotionCarouselWidget(),
        SearchButton(),
        CategorySection(),
        PopularProductGrid(),
        SpecialOfferProduct(),
        TodaysSpecialOffers(),
      ],
    );
  }
}
