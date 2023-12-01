import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HeadlineDetailsPage extends StatelessWidget {
  final String headlineUrl;

  const HeadlineDetailsPage({required this.headlineUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = WebViewController()
      ..loadRequest(Uri.parse(headlineUrl))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('News Details'),
      ),
      body: WebViewWidget(controller: _controller,),
    );
  }
}
