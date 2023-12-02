import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/models/news.dart';
import 'package:news_application/models/news_headlines.dart';
import 'package:news_application/pages/headlines_details_page.dart';
import 'package:news_application/pages/news_categories_page.dart';
import 'package:news_application/pages/news_details_page.dart';
import 'package:news_application/view_model/news_view.dart';

import '../utils/constant.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

enum FilterList { bbcNews, abcNews, nationalGeographic, cnn, alJazeera, espn }

class _NewsHomePageState extends State<NewsHomePage> {
  NewsView newsView = NewsView();
  FilterList? selectedMenu;
  String channelName = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewsCategoriesPage()));
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
              if (FilterList.bbcNews.name == item.name) {
                channelName = 'bbc-news';
              }
              if (FilterList.abcNews.name == item.name) {
                channelName = 'abc-news';
              }
              if (FilterList.nationalGeographic.name == item.name) {
                channelName = 'national-geographic';
              }
              if (FilterList.cnn.name == item.name) {
                channelName = 'cnn';
              }
              if (FilterList.alJazeera.name == item.name) {
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
            icon: Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
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
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HeadlineDetailsPage(
                                      headlineUrl: item.url.toString()))),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                width: MediaQuery.of(context).size.height * 0.5,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: item.urlToImage.toString(),
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
                              ),
                              Positioned(
                                bottom: 10,
                                child: Card(
                                  color: Colors.blueGrey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 5,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    height: MediaQuery.of(context).size.height *
                                        .22,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${item.source!.name}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.blue),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13,
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
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .55,
            width: MediaQuery.of(context).size.width * .55,
            child: FutureBuilder<News>(
              future: newsView.getNews(),
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
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data!.articles![index];
                      DateTime dateTime =
                          DateTime.parse(item.publishedAt.toString());
                      return Card(
                        shadowColor: Colors.blue,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailsPage(
                                  newsImage: item.urlToImage.toString(),
                                  newsTitle: item.title.toString(),
                                  newsDescription: item.description.toString(),
                                  newsSourceName: item.source!.name.toString(),
                                  newsAuthor: item.author.toString(),
                                  newsDate: item.publishedAt.toString(),
                                  newsContent: item.content.toString(),
                                  newsUrl: item.url.toString(),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: item.urlToImage.toString(),
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
                                  '${item.title}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '${item.description}',
                                  maxLines: 3,
                                  style: GoogleFonts.poppins(
                                      fontSize: 11, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  'Source :${item.source!.name}',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                ),
                                Text(
                                  '${item.author}',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                ),
                                Text(format.format(dateTime)),
                              ],
                            ),
                          ),
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
