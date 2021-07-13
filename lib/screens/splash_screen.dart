import 'package:flutter/material.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;

class SplashScreen extends StatefulWidget {
  static const String id="splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.darkGrey.withOpacity(0.5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.3,
              ),
              Image(image: AssetImage("assets/ksu_masterlogo_colour_rgb.png"),),
            ],
          ),
        ),
      ),
    );
  }
}
