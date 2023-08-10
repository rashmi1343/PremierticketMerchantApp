import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptk_merchant/util/appConstant.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class EventsWebview extends StatefulWidget {
  @override
  EventsWebviewState createState() {
    return EventsWebviewState();
  }
}

class EventsWebviewState extends State<EventsWebview> {
  // late InAppWebViewController webView;
  // late InAppWebViewController _webViewPopupController;
  bool isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late WebViewController _webViewController;
  var isdownload = false;

  @override
  void initState() {
    super.initState();
  }

  final _key = UniqueKey();
  int _stackToView = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: IndexedStack(
        index: _stackToView,
        children: <Widget>[
          WebView(
            initialUrl: '${ApiConstant.url + "BOOKINGAPI/eventdetail"}',
            javascriptMode: JavascriptMode.unrestricted,
            zoomEnabled: false,
            onWebViewCreated: (WebViewController webViewController) {
              setState(() {
                _webViewController = webViewController;
                _controller.complete(webViewController);
              });
            },
            onProgress: (int progress) {
              print("WebView is loading (progress : $progress%)");

            },
            onPageStarted: (String url) {
              print('Page started loading: $url');

            },
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer()),
              Factory<HorizontalDragGestureRecognizer>(
                  () => HorizontalDragGestureRecognizer()),
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer()),
              Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
            },
            gestureNavigationEnabled: true,
          ),
        ],
      )),
    );
  }
}
