
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../utils/basic_import.dart';

class FlutterWebScreen extends StatefulWidget {
  const FlutterWebScreen({
    super.key,
    required this.url,
    this.onFinished,
    this.onHomeClick,
  });

  final String url;
  final Function? onFinished;
  final VoidCallback? onHomeClick;

  @override
  State<FlutterWebScreen> createState() => _FlutterWebScreenState();
}

class _FlutterWebScreenState extends State<FlutterWebScreen> {
  late InAppWebViewController webViewController;

  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "",
        showBackButton: true,
        action: [
          widget.onHomeClick == null
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: widget.onHomeClick, icon: Icon(Icons.home_max))
        ],
      ),
      body: SafeArea(child: _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(widget.url)),
      onWebViewCreated: (controller) {
        webViewController = controller;
        controller.addJavaScriptHandler(
          handlerName: 'jsHandler',
          callback: (args) {
            // Handle JavaScript messages from WebView
          },
        );
      },
      onLoadStart: (controller, url) {
        widget.onFinished!(url);
      },
      onLoadStop: (controller, uri) async {
        // Inject JavaScript to disable click events for buttons and other interactive elements
        // await controller.evaluateJavascript(source: """
        //   // Disable clicks on buttons
        //   document.querySelectorAll('button').forEach(button => {
        //     button.disabled = true;
        //     button.style.pointerEvents = 'none';
        //   });
        //
        //   // Disable clicks on links (anchor tags)
        //   document.querySelectorAll('a').forEach(link => {
        //     link.style.pointerEvents = 'none';
        //   });
        //
        //   // Disable form submissions
        //   document.querySelectorAll('form').forEach(form => {
        //     form.onsubmit = function(e) {
        //       e.preventDefault();
        //     };
        //   });
        // """);
      },
    );
  }
}
