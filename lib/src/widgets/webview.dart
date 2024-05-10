import 'package:contest_app/src/constants/appcolors.dart';
import 'package:flutter/cupertino.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? _controller;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onUrlChange: (change) {
            // final url = Uri.parse(change.url!);
            // String? trxRef = url.queryParameters["trxref"];
            // String? reference = url.queryParameters["reference"];
            // debugPrint("___ trxref $trxRef _____  reference $reference");
            // if(trxRef != null && reference != null){
            //   Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) {
            //     return const VerifyTransactionPage();
            //   },), (route) => false);
            // }
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
        ),
        backgroundColor: AppColor.primaryColor,
      ),
      body: SafeArea(
        child: WebViewWidget(
          controller: _controller!,
        ),
      ),
    );
  }
}
