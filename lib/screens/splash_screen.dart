import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:ksu_scholarship/problem_domain/Algorithm.dart';
import 'package:ksu_scholarship/screens/auth_screen.dart';
import 'package:ksu_scholarship/screens/mother_screen.dart';
import 'package:ksu_scholarship/constant/version.dart';
class SplashScreen extends StatefulWidget {
  static const String id="splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3));

      checkUser();

    super.initState();
  }

/*  getVersion()async{
    DocumentSnapshot _version= await retrieveVersion();
    print(_version['android']);
    if(_version['android']=='0.0.0'){
      return true;
    }
    return false;
  }*/

  Future<void> checkUser()async{
    if( await FirebaseAuth.instance.currentUser != null ){
      Navigator.pushNamed(context, MotherScreen.id);
    }else{
      Navigator.pushNamed(context, AuthScreen.id);
    }
  }

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
