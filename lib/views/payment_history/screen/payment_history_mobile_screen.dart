part of 'payment_history_screen.dart';

class PaymentHistoryMobileScreen extends GetView<PaymentHistoryController> {
  const PaymentHistoryMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(Strings.paymentHistory),
      body: Obx(() =>
          controller.isPaymentHistoryLoading ? Loader() : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => controller.paymentHistoryList.isEmpty
            ? NoDataWidget(
              emptyMessage: Strings.historyNotFound,
            )
            : ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.horizontalSize * .7,
                  vertical: Dimensions.verticalSize * .3,
                ),
                itemCount: controller.paymentHistoryList.length,
                itemBuilder: (context, index) {
                  var data = controller.paymentHistoryList[index];
                  return TransactionCard(data: data, index: index);
                },
              ),
      ),
    );
  }
}
