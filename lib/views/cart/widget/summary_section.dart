part of '../screen/cart_screen.dart';

class SummarySection extends GetView<CartController> {
  const SummarySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.paddingSize * 0.2,
        top: Dimensions.paddingSize * 0.5,
      ),
      child: Obx(() {
        // 👇 1. CHECK USER TYPE
        // If Wholesaler -> Hide this entire section
        if (controller.userType.value.toLowerCase() == 'wholesaler') {
          return const SizedBox.shrink();
        }

        // 👇 2. RETAILER -> Show the summary as normal
        return Column(
          children: [
            _summaryRow(Strings.subTotal, controller.subtotal.value.toStringAsFixed(2)),
            _summaryRow(Strings.discount, controller.discount.value.toStringAsFixed(2)),
            DividerWidget(),
            _summaryRow(Strings.total, controller.total.value.toStringAsFixed(2),
                isTotal: true),
          ],
        );
      }),
    );
  }

  Widget _summaryRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.heightSize * .2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            label,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            typographyStyle: TypographyStyle.labelMedium,
          ),
          TextWidget(
            "${controller.currencySymbol}$amount",
            color: isTotal ? CustomColor.primary : null,
            typographyStyle: TypographyStyle.labelMedium,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          ),
        ],
      ),
    );
  }
}