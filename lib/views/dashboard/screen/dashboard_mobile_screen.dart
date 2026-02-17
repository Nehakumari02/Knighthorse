part of 'dashboard_screen.dart';


class DashboardMobileScreen extends GetView<DashboardController> {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarWidget(),
      body: Obx(() {
        // 1. ADD THIS CHECK: If user type isn't fetched, the whole logic is on hold
        bool isInitializing = controller.fetchedUserType.value.isEmpty;

        // 2. CHECK ALL LOADERS
        bool isLoading = controller.isBannerOfferLoading ||
            controller.isPopularLoading ||
            controller.specialProductLoading ||
            controller.isAllProductLoading;

        if (isInitializing || isLoading) {
          return const Loader(); // Constant loader until everything is ready
        }

        return _bodyWidget(context);
      }),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        PromotionCarouselWidget(),
        SearchButton(),
        CategorySection(),
        FeaturedCategoriesSection(),
        AllProductsGrid(),
        PopularProductGrid(),
        SpecialOfferProduct(),
        TodaysSpecialOffers(),

      ],
    );
  }
}
