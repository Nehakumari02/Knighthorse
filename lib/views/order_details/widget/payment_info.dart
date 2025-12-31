part of '../screen/order_details_screen.dart';

class PaymentInfo extends GetView<OrderDetailsController> {
  const PaymentInfo({Key? key}) : super(key: key);

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
              Strings.paymentInfo,
              fontSize: Dimensions.titleMedium * 1.25,
              fontWeight: FontWeight.w500,
            ),
            DividerWidget(),
            // DoubleSideTextWidget(
            //   keys: Strings.paymentMethod,
            //   value: controller.paymentMethod.value,
            // ),
            // Sizes.height.v5,
            DoubleSideTextWidget(
              keys: Strings.transactionId,
              value: controller.transactionID.value,
            ),
            Sizes.height.v5,
            DoubleSideTextWidget(
              keys: Strings.orderDate,
              value: controller.orderDate.value,
            ),
            Sizes.height.v5,
            _buildInfoRowStatus(controller.orderStatus.value),
          ],
        ),
      ),
    );
  }

  _buildInfoRowStatus(int status) {
    return Row(
      children: [
        Expanded(
            child: TextWidget(
          Strings.orderStatus,
          typographyStyle: TypographyStyle.labelMedium,
        )),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.horizontalSize * 0.4,
            vertical: Dimensions.verticalSize * 0.15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.6),
            color: status == 1
                ? CustomColor.selected.withValues(alpha: 0.5)
                : status == 2
                    ? CustomColor.pending.withValues(alpha: 0.5)
                    : CustomColor.rejected.withValues(alpha: 0.5),
          ),
          child: Row(
            children: [
              Icon(
                status == 1
                    ? Icons.check_circle
                    : status == 2
                        ? Icons.check_circle
                        : Icons.block_outlined,
                color: status == 1
                    ? CustomColor.selected
                    : status == 2
                        ? CustomColor.pending
                        : CustomColor.rejected,
                size: Dimensions.iconSizeDefault,
              ),
              Sizes.width.v5,
              TextWidget(
                status == 1
                    ? Strings.success
                    : status == 2
                        ? Strings.pending
                        : Strings.rejected,
                typographyStyle: TypographyStyle.labelMedium,
                color: status == 1
                    ? CustomColor.selected
                    : status == 2
                        ? CustomColor.pending
                        : CustomColor.rejected,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
