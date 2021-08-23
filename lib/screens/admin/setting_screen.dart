import 'package:flutter/material.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;

class AdminSettingScreen extends StatefulWidget {
  static const String id="admin_setting_screen";
  @override
  _AdminSettingScreenState createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              color: color.primaryColor,
            ),
            child: Column(
              children: [
                Expanded(child: Container()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "الإعدادات",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}

