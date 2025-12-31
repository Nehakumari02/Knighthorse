part of '../screen/order_details_screen.dart';

class BillingSummary extends GetView<OrderDetailsController> {
  const BillingSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            DividerWidget(),
            DoubleSideTextWidget(
              keys: Strings.subTotal,
              value:
                  "${controller.subTotal.value}${controller.currencySymbol.value}",
            ),
            DoubleSideTextWidget(
              keys: Strings.deliveryCharge,
              value:
                  "${controller.deliveryCharge.value}${controller.currencySymbol.value}",
            ),
            // DoubleSideTextWidget(
            //   keys: Strings.reusableBag,
            //   value:
            //       "${controller.reusableBag.value}${controller.currencySymbol.value}",
            // ),
            DoubleSideTextWidget(
              keys: Strings.paymentGatewayCharge,
              value:
                  "${controller.paymentGatewayCharge.value}${controller.currencySymbol.value}",
            ),
            DividerWidget(),
            DoubleSideTextWidget(
              keys: Strings.totalAmount,
              keyTextStyle:
                  CustomStyle.labelMedium.copyWith(fontWeight: FontWeight.w700),
              value:
                  "${controller.totalAmount.value}${controller.currencySymbol.value}",
            ),
          ],
        ),
      ),
    );
  }
}
