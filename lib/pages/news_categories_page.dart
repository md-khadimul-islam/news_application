import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application/models/news_categories.dart';
import 'package:news_application/view_model/news_view.dart';

class NewsCategoriesPage extends StatefulWidget {
  const NewsCategoriesPage({super.key});

  @override
  State<NewsCategoriesPage> createState() => _NewsCategoriesPageState();
}

class _NewsCategoriesPageState extends State<NewsCategoriesPage> {
  NewsView newsView = NewsView();

  final format = DateFormat('MMM dd, yyyy');
  String categoryName = 'general';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Categories News', style: GoogleFonts.novaSquare(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  final citem = categoriesList[index];
                  return InkWell(
                    onTap: () {
                      categoryName = citem;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryName == citem
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              citem.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: Colors.black, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: FutureBuilder<NewsCategories>(
              future: newsView.fetchNewsCategories(categoryName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitRing(
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: item.urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  height: height * .18,
                                  width: width * .3,
                                    placeholder: (context, url) => Center(child: SpinKitCircle(color: Colors.blue, size: 50,),),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error_outline,
                                    size: 50,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height * .18,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  children: [
                                    Text(
                                      '${item.title}',
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                         children: [
                                           Row(
                                             children: [
                                               Text(
                                                 '${item.source!.name}',
                                                 style: GoogleFonts.poppins(
                                                     fontWeight: FontWeight.w700,
                                                     color: Colors.black54,
                                                     fontSize: 15),
                                               ),
                                               SizedBox(width: 40,),
                                               Text(
                                                 format.format(dateTime),
                                                 style: GoogleFonts.poppins(
                                                     fontWeight: FontWeight.w700,
                                                     fontSize: 15,
                                                     color: Colors.black54),
                                               ),
                                             ],
                                           ),
                                         ],
                                      ),
                                    ),
                                  ],
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
