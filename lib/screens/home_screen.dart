import 'package:flutter/material.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List listOfServices = [
    {"title": "طلب تأشيرة خروج وعودة", "icon": Icons.airplanemode_active},
    {"title": "طلب اسكان", "icon": Icons.home},
    {"title": "طلب تغذية", "icon": Icons.fastfood_rounded},
    {"title": "طلب إعانة", "icon": Icons.volunteer_activism},
  ];

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
                        "الصفحة الرئيسية",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 0
              ),
              itemCount: listOfServices.length,
              itemBuilder: (context, index)=>
                  ServiceItem(
                    "${listOfServices[index]['title'].toString()}",
                    listOfServices[index]['icon'],
                  ),
            ),
            // child: ListView.builder(
            //   shrinkWrap: true,
            //   // reverse: true,
            //   // scrollDirection: Axis.horizontal,
            //   itemBuilder: (BuildContext context, index) {
            //     return ServiceItem(
            //       "${listOfServices[index]['title'].toString()}",
            //       listOfServices[index]['icon'],
            //     );
            //   },
            //   itemCount: listOfServices.length,
            // ),
          ),
          // Column(
          //   children: [
          //     ServiceItem("Hello",Icons.home,),
          //   ],
          // )
        ],
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  ServiceItem(this.title, this.icon);

  String title;
  String widgetRoute;
  IconData icon;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: InkWell(
        child: Container(
          // height: 0,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.red,
              border: Border.all(
                color: Colors.grey[700],
              ),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 55,
                  color: color.primaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                AutoSizeText(
                  title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: color.primaryColor, fontSize: 20, ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}