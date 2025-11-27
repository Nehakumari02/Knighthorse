part of '../screen/payment_screen.dart';

class WebPaymentScreen extends StatelessWidget {
  WebPaymentScreen({super.key});
  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('', showBackButton: true),
      body: Obx(
        () => controller.isCheckingOut ? const Loader() : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    final paymentUrl = controller.onlinePaymentModel.data.redirectUrl;

    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(paymentUrl)),
      onWebViewCreated: (InAppWebViewController inAppWebViewController) {},
      onProgressChanged:
          (InAppWebViewController inAppWebViewController, int progress) {},
      onLoadStop: (InAppWebViewController inAppWebViewController, url) async {
        if (url != null) {
          String? pageContent = await inAppWebViewController.evaluateJavascript(
            source: "document.body.innerText",
          );

          if (pageContent != null && pageContent.isNotEmpty) {
            try {
              Map<String, dynamic> parsedJson = json.decode(pageContent);
              if (parsedJson['type'] == 'success') {
                Congratulation congratulation = Congratulation(
                  details: parsedJson['message']['success'].first,
                  route: Routes.navigation,
                  buttonText: Strings.backToHome,
                  type: Strings.onlinePayment,
                );
                Get.to(
                  () => CongratulationsScreen(),
                  arguments: congratulation,
                )?.then((_) {
                  controller.clearCart();
                });
              } else if (parsedJson['type'] == 'error') {
                Get.close(1);
                CustomSnackBar.error(
                  parsedJson['message']['error'].first,
                );
              }
            } catch (e) {
              debugPrint("Error parsing JSON: $e");
            }
          }
        }
      },
    );
  }
}
