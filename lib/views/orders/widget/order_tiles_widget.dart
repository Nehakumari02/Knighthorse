part of '../screen/orders_screen.dart';

class OrderTilesWidget extends GetView<OrdersController> {
  final int index;
  const OrderTilesWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = controller.orderList[index];
    return GestureDetector(
      onTap: () {
        controller.orderId.value = data.uuid;
        Routes.orderDetailsScreen.toNamed;
      },
      child: Card(
        margin: EdgeInsets.only(
          bottom: Dimensions.heightSize,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.horizontalSize * .7,
              vertical: Dimensions.verticalSize * .5),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  TextWidget(
                    "#${data.trxId}",
                  ),
                  _statusWidget(data.status)
                ],
              ),
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  // TextWidget(
                  //   "${Strings.deliveryDate}: ${data.date}",
                  //   typographyStyle: TypographyStyle.labelSmall,
                  // ),
                  TextWidget("${data.amount} ${data.defaultCurrencyCode}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _statusWidget(int status) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        Row(
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
              typographyStyle: TypographyStyle.labelSmall,
              color: status == 1
                  ? CustomColor.selected
                  : status == 2
                      ? CustomColor.pending
                      : CustomColor.rejected,
            ),
          ],
        ),
      ],
    );
  }
}
