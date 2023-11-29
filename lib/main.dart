import 'package:flutter/material.dart';
import 'package:news_application/pages/news_home_page.dart';
import 'package:news_application/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      // home: AnimatedSplashScreen(
      //   nextScreen: const NewsHomePage(),
      //   splash: 'images/app_icon.jpg',
      //   duration: 4000,
      //   backgroundColor: Colors.black,
      // ),
    );
  }
}
