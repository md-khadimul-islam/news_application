import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application/models/news_headlines.dart';
import 'package:news_application/pages/news_categories_page.dart';
import 'package:news_application/view_model/news_view.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

enum FilterList { bbcNews , abcNews , nationalGeographic , cnn , alJazeera, espn }

class _NewsHomePageState extends State<NewsHomePage> {
  NewsView newsView = NewsView();
  final format = DateFormat('MMMM dd, yyyy');
  FilterList? selectedMenu;
  String channelName = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsCategoriesPage()));
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            onSelected: (FilterList item) {
              if(FilterList.bbcNews.name == item.name) {
                channelName = 'bbc-news';
              }
              if(FilterList.abcNews.name == item.name) {
                channelName = 'abc-news';
              }
              if(FilterList.nationalGeographic.name == item.name) {
                channelName = 'national-geographic';
              }
              if(FilterList.cnn.name == item.name) {
                channelName = 'cnn';
              }
              if(FilterList.alJazeera.name == item.name) {
                channelName = 'al-jazeera-english';
              }
              if (FilterList.espn.name == item.name) {
                channelName = 'espn';
              }

              setState(() {
                selectedMenu = item;
              });
            },
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert_outlined, color: Colors.black,),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: Text('BBC News'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.abcNews,
                child: Text('ABC News'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.nationalGeographic,
                child: Text('National Geographic'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.cnn,
                child: Text('CNN'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.alJazeera,
                child: Text('Al Jazeera'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.espn,
                child: Text('ESPN'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.55,
            child: FutureBuilder<NewsHeadlines>(
              future: newsView.fetchNewsHeadlines(channelName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCubeGrid(
                      color: Colors.blue,
                      size: 50,
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data!.articles![index];
                      DateTime dateTime =
                          DateTime.parse(item.publishedAt.toString());
                      return SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.height * 0.9,
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: item.urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height:
                                      MediaQuery.of(context).size.height * .22,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            item.title.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '${item.source!.name}',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blue),
                                            ),
                                            SizedBox(
                                              width: 80,
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
