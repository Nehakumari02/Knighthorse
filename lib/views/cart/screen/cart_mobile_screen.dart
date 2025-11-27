part of 'cart_screen.dart';

class CartMobileScreen extends GetView<CartController> {
  const CartMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        Strings.cart,
        showBackButton: false,
      ),
      body: Obx(() => controller.cartItems.isEmpty
          ? NoDataWidget(
              asset: 'assets/animation/emptyCart.json',
              mainAlignment: mainStart,
              height: MediaQuery.sizeOf(context).height * .4,
            )
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.defaultHorizontalSize),
        child: Visibility(
          visible: controller.cartItems.isNotEmpty,
          child: Column(
            children: [
              Expanded(child: CartItemList()),
              SummarySection(),
              CheckoutButton()
            ],
          ),
        ),
      ),
    );
  }
}
