import 'package:flutter/material.dart';
import 'package:news_application/pages/new_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 4),
          () =>
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewsHomePage(),
            ),
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
            'images/app_logo.png',
        ),
      ),
    );
  }
}
