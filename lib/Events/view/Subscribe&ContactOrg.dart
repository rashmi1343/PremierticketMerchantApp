import 'dart:io'; // Add this import.
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/appConstant.dart';

class SubscribeAndContactOrg extends StatefulWidget {
  final isFromSubscribeNow;

  const SubscribeAndContactOrg({super.key, required this.isFromSubscribeNow});
  @override
  _SubscribeAndContactOrgState createState() => _SubscribeAndContactOrgState();
}

class _SubscribeAndContactOrgState extends State<SubscribeAndContactOrg> {
  late final WebViewController _controller;

  var url = '';
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    if (widget.isFromSubscribeNow) {
      url = "${ApiConstant.url}subscribenow.html";
    } else {
      url = "${ApiConstant.url}contactorganisermobile.html";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 75,
        backgroundColor: const Color(0xfff9fdfe),
        elevation: 0,
        title: Image.asset(
          'assets/images/logoptk.png',
          width: 110,
          height: 75,
        ),
        leading: Builder(
          builder: (context) => Container(
            margin: const EdgeInsets.only(left: 10),
            child: IconButton(
              alignment: Alignment.centerLeft,
              icon: Image.asset(
                "assets/images/back.png",
                color: const Color(0xff000000),
                height: 21,
                width: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 11, 72, 122),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
