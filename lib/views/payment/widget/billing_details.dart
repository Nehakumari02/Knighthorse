part of '../screen/payment_screen.dart';

class BillingDetails extends GetView<CartController> {
  const BillingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: Dimensions.verticalSize * 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalSize,
            vertical: Dimensions.verticalSize * .8,
          ),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              TextWidget(
                Strings.billingDetails,
                fontSize: Dimensions.titleMedium * 1.25,
                fontWeight: FontWeight.w500,
              ),
              Sizes.height.v10,
              // DoubleSideTextWidget(
              //   keys: Strings.subtotal,
              //   value: controller.total.value.toStringAsFixed(2),
              // ),
              // DoubleSideTextWidget(
              //   keys: Strings.deliveryCharge,
              //   value: controller.deliveryCharge.value.toStringAsFixed(2),
              // ),
              DoubleSideTextWidget(
                keys: "Total Items",
                value: "${controller.cartItems.length}",
              ),
              // --- QUANTITY FIELD ---
              Sizes.height.v10,
              DoubleSideTextWidget(
                keys: "Total Quantity",
                // This sums up the .value of every RxInt quantity in your cart
                value: "${controller.cartItems.fold(0, (sum, item) => sum + item.quantity.value)} ",
              ),

              _checkBoxWidget(context),
              // --- Hiding Wallet Balance ---
              Visibility(
                visible: false, // <--- Set to false to hide wallet balance
                child: DoubleSideTextWidget(
                    keys: Strings.walletBalance,
                    value: double.parse(double.parse(controller.walletBalance.toString()).toStringAsFixed(2))
                        .toStringAsFixed(2)),
              ),
              // -----------------------------
              DividerWidget(),
              // DoubleSideTextWidget(
              //     keys: Strings.totalCost,
              //     value: controller.totalCost.value.toStringAsFixed(2))
            ],
          ),
        ),
      ),
    );
  }

  _checkBoxWidget(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: false, // <--- Changed to false to hide the widget entirely
        // visible: DeliveryServices.bagStatus.value == 1, // (Old logic commented out)
        child: Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            Row(
              children: [
                Transform.translate(
                  offset: Offset(-8, 0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Checkbox(
                      value: controller.isChecked.value,
                      onChanged: (bool? value) {
                        controller.isChecked.value = value ?? false;
                        controller.toggleReusableBag(value ?? false);
                      },
                    ),
                  ),
                ),
                TextWidget(
                  Strings.addReusableBags,
                  typographyStyle: TypographyStyle.labelMedium,
                ),
              ],
            ),
            TextWidget(
              controller.isChecked.value
                  ? controller.reusableBagPrice.value.toString()
                  : "",
              typographyStyle: TypographyStyle.labelMedium,
            ),
          ],
        ),
      );
    });
  }
}
