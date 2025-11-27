part of 'payment_history_screen.dart';

class PaymentHistoryTabletScreen extends GetView<PaymentHistoryController> {
  const PaymentHistoryTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('PaymentHistory Tablet Screen'),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [],
      ),
    );
  }
}
