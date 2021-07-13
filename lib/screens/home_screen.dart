import 'package:flutter/material.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ksu_scholarship/screens/orders/housing_order_screen.dart';
import 'package:ksu_scholarship/screens/orders/food_supply_order_screen.dart';
import 'package:ksu_scholarship/screens/orders/visa_order_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List listOfServices = [
    {"title": "طلب تأشيرة خروج وعودة", "icon": Icons.airplanemode_active, "route":VisaOrderScreen.id},
    {"title": "طلب اسكان", "icon": Icons.home, "route":HousingOrderScreen.id},
    {"title": "طلب تغذية", "icon": Icons.fastfood_rounded,"route":FoodSupplyOrderScreen.id},
    // {"title": "طلب إعانة", "icon": Icons.volunteer_activism, "route":HousingOrderScreen.id},
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
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 0
              ),
              itemCount: listOfServices.length,
              itemBuilder: (context, index)=>
                  ServiceItem(
                    title: "${listOfServices[index]['title'].toString()}",
                    icon: listOfServices[index]['icon'],
                    route: listOfServices[index]['route'],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  ServiceItem({this.title, this.icon, this.route});

  String title;
  String widgetRoute;
  String route;
  IconData icon;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, route);
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
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