import 'dart:async';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/utils/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsPage extends StatelessWidget {
  final String newsImage,
      newsTitle,
      newsDescription,
      newsSourceName,
      newsAuthor,
      newsContent,
      newsUrl,
      newsDate;

  const NewsDetailsPage({
    required this.newsImage,
    required this.newsTitle,
    required this.newsDescription,
    required this.newsSourceName,
    required this.newsAuthor,
    required this.newsDate,
    required this.newsContent,
    required this.newsUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(newsDate);
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('News Details'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: newsImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error_outline,
                    size: 50,
                    color: Colors.red,
                  ),
                ),
              ),
              Text(
                newsTitle,
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                newsDescription,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 13),
              ),
              Text(
                newsContent,
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Source : ${newsSourceName}',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black),
              ),
              Text(
                newsAuthor,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black),
              ),
              Text(
                format.format(dateTime),
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Visit WebSite: '),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   height: 250,
              //   child: WebView(
              //     initialUrl: newsUrl ?? 'https://flutter.dev',
              //     javascriptMode: JavascriptMode.unrestricted,
              //     onWebViewCreated: (WebViewController webViewController) {
              //       _controller.complete(webViewController);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
