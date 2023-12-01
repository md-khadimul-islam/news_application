import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CategoriesDetailsPage extends StatelessWidget {
  final String categoriesUrl;

  const CategoriesDetailsPage({required this.categoriesUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = WebViewController()
      ..loadRequest(Uri.parse(categoriesUrl))
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
