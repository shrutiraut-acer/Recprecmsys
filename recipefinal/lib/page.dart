//import 'package:flutter/material.dart';
//import 'package:recipefinal/recipe_view.dart';

//import 'package:url_launcher/url_launcher.dart';
//import 'package:recipefinal/recipe_view.dart';

//import 'package:webview_flutter/webview_flutter.dart';
//import 'package:webview_flutter/webview_flutter.dart';


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageInfo extends StatefulWidget {
  final String url;
  PageInfo({super.key, required this.url});

  @override
  State<PageInfo> createState() => _PageInfoState();
}

class _PageInfoState extends State<PageInfo> {
  late WebViewController controller;
  // final controller = WebViewController()
  //   ..setJavaScriptMode(JavaScriptMode.disabled)
  //   ..loadRequest(Uri.parse("https://amazon.com"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.url),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                launchUrl(Uri.parse(widget.url));
              },
              child: Text("open ")),
        ));
  }
}
/*
class _PageInfoState extends State<PageInfo> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse("https://amazon.com"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.url),
        ),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
 */