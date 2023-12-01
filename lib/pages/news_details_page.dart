import 'package:flutter/material.dart';
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
    // DateTime dateTime = DateTime.parse(newsDate);
    // bool isLoading = true;
    final _controller = WebViewController()
      ..loadRequest(Uri.parse(newsUrl))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('News Details'),
      ),
      body: WebViewWidget(
        controller: _controller,
      ) ,
      // body: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Padding(
      //     padding: const EdgeInsets.all(12.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         ClipRRect(
      //           borderRadius: BorderRadius.circular(16),
      //           child: CachedNetworkImage(
      //             imageUrl: newsImage,
      //             fit: BoxFit.cover,
      //             placeholder: (context, url) => Center(
      //               child: SpinKitCircle(
      //                 color: Colors.blue,
      //                 size: 50,
      //               ),
      //             ),
      //             errorWidget: (context, url, error) => Icon(
      //               Icons.error_outline,
      //               size: 50,
      //               color: Colors.red,
      //             ),
      //           ),
      //         ),
      //         Text(
      //           newsTitle,
      //           style: GoogleFonts.poppins(
      //               fontSize: 15,
      //               color: Colors.black,
      //               fontWeight: FontWeight.w700),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Text(
      //           newsDescription,
      //           style: GoogleFonts.poppins(
      //               fontWeight: FontWeight.w400, fontSize: 13),
      //         ),
      //         Text(
      //           newsContent,
      //           style: GoogleFonts.poppins(
      //               fontSize: 13, fontWeight: FontWeight.w400),
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //         Text(
      //           'Source : ${newsSourceName}',
      //           style: GoogleFonts.poppins(
      //               fontWeight: FontWeight.w700,
      //               fontSize: 15,
      //               color: Colors.black),
      //         ),
      //         Text(
      //           newsAuthor,
      //           style: GoogleFonts.poppins(
      //               fontWeight: FontWeight.w700,
      //               fontSize: 15,
      //               color: Colors.black),
      //         ),
      //         Text(
      //           format.format(dateTime),
      //           style: GoogleFonts.poppins(
      //               fontSize: 13, fontWeight: FontWeight.w400),
      //         ),
      //         SizedBox(
      //           height: 30,
      //         ),
      //         Container(
      //           height: 200,
      //           width: 200,
      //
      //           child: PlatformViewPlaceholder<RenderAndroidView>(
      //
      //             controller: _controller,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
