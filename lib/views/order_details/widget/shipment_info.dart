part of '../screen/order_details_screen.dart';


class ShipmentInfo extends GetView<OrderDetailsController> {
  const ShipmentInfo({Key? key}) : super(key: key);

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
              "Shipment Details",
              fontSize: Dimensions.titleMedium * 1.25,
              fontWeight: FontWeight.w500,
            ),
            DividerWidget(),

            // 1. Tracking Number Row (Existing)
            DoubleSideTextWidget(
              leftWidget: _leftInfoWidget(
                "Tracking Number",
                controller.trackingNumber.value,
              ),
              rightWidget: _rightInfoWidget(
                "",
                '',
              ),
            ),
            DividerWidget(),

            // 2. Courier Company Widget (New)
            _leftInfoWidget(
              "Courier Company",
              controller.courierCompany.value.isEmpty ? "N/A" : controller.courierCompany.value,
            ),
            DividerWidget(),

            // 3. Tracking Link Widget (New & Clickable)
            GestureDetector(
              onTap: () => controller.launchTrackingUrl(),
              child: _leftInfoWidget(
                "Tracking Link",
                controller.trackingLink.value.isEmpty ? "Not Available" : controller.trackingLink.value,
                valueTextStyle: TextStyle(
                  color: CustomColor.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _rightInfoWidget(
    String key,
    String value, {
    TextStyle? keyTextStyle,
    TextStyle? valueTextStyle,
  }) {
    return Column(
      crossAxisAlignment: crossEnd,
      mainAxisSize: mainMin,
      mainAxisAlignment: mainStart,
      children: [
        TextWidget(
          key,
          typographyStyle: TypographyStyle.labelSmall,
          style: keyTextStyle,
        ),
        Sizes.height.v5,
        TextWidget(
          value,
          textAlign: TextAlign.end,
          style: valueTextStyle,
          typographyStyle: TypographyStyle.labelLarge,
        ),
      ],
    );
  }

  _leftInfoWidget(
    String key,
    String value, {
    String? charges,
    TextStyle? keyTextStyle,
    TextStyle? valueTextStyle,
  }) {
    return Column(
      crossAxisAlignment: crossStart,
      mainAxisSize: mainMin,
      mainAxisAlignment: mainStart,
      children: [
        TextWidget(
          key,
          typographyStyle: TypographyStyle.labelSmall,
          style: keyTextStyle,
        ),
        if (charges != null)
          TextWidget(
            "($charges)",
            typographyStyle: TypographyStyle.labelSmall,
            color: CustomColor.primary,
            padding: Dimensions.heightSize.edgeTop * 0.2,
          ),
        Sizes.height.v5,
        TextWidget(
          value,
          textAlign: TextAlign.start,
          style: valueTextStyle,
          typographyStyle: TypographyStyle.labelLarge,
        ),
      ],
    );
  }
}
