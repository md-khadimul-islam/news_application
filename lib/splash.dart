import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/pages/news_home_page.dart';

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
          Navigator.pushReplacement(
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'images/app_logo.png',
            ),
            SizedBox(height: 10,),
            Text('TOP HEADLINES' , style: GoogleFonts.novaSquare(color: Colors.white70, fontSize: 25),),
            SizedBox(height: 20,),
            SpinKitSpinningLines(color: Colors.blue, size: 60,),
          ],
        ),
      ),
    );
  }
}
