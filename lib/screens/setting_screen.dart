import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:ksu_scholarship/constant/Widgets.dart' as widgets;

class SettingScreen extends StatefulWidget {
  static const String id = "setting_screen";

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    double bottomSheetHeight = 250;

    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      if (visible) {
        print("it's open");
        setState(() {
          bottomSheetHeight = MediaQuery.of(context).size.height * 0.65;
        });
      } else {
        print("closed");
        setState(() {
          bottomSheetHeight = MediaQuery.of(context).size.height * 0.3;
        });
      }
    });

    Future<void> changePersonalInformation(String title) {
      return showModalBottomSheet(
          backgroundColor: Color(0x00000000),
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (BuildContext context,
                StateSetter setState /*You can rename this!*/) {
              return Container(
                  height: bottomSheetHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 70,
                        // color: Colors.red,
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: color.primaryColor,
                                    fontSize: 24,
                                    fontFamily: "Cairo",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 25,
                              child: widgets.ExitButton(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(right: 30, left: 30, bottom: 10,),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            style: TextStyle(
                              color: color.primaryColor, fontSize: 20,),
                            decoration: InputDecoration(
                              labelText: title,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                        child: InkWell(
                          child: Container(
                            width: double.infinity,
                            // height: 30,
                            margin: EdgeInsets.only(top: 0, bottom: 30,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: color.primaryColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5,),
                              child: Center(
                                child: Text(
                                  "تحديث",
                                  style: TextStyle(
                                    color: Colors.white, fontSize: 20,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            });
          });
    }

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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10,),
                    child: Container(
                      width: double.infinity,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "الإعدادات",
                          style: TextStyle(color: Colors.white, fontSize: 24,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30, left: 20, right: 20,),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DepContainer(
                      "البيانات الشخصية",
                      children: [
                        SettingDataCard(
                          "الاسم",
                          "محمد علي خالد",
                        ),
                        SettingDataCard(
                          "الاسم باللغة الانجليزية",
                          "محمد علي خالد",
                        ),
                        SettingDataCard("الجنسية", "صومالي",),
                        SettingDataCard("البلد", "صومالي",),
                        SettingDataCard("تاريخ الميلاد", "28",),
                      ],
                    ),
                    DepContainer(
                      "بيانات الهوية",
                      children: [
                        SettingDataCard("رقم الهوية", "16",),
                        SettingDataCard("تاريخ انتهاء الهوية", "4",),
                        // SettingDataCard("رقم الجواز", "16",),
                        // SettingDataCard("تاريخ انتهاء الجواز", "2",),
                      ],
                    ),
                    DepContainer(
                      "البيانات الأكاديمية",
                      children: [
                        SettingDataCard("الرقم الجامعي", "00000000",),
                        SettingDataCard("الدرجة العلمية", "بكالوريوس",),
                        SettingDataCard("الكلية", "علوم العمارة والتخطيط",),
                        SettingDataCard("التخصص", "تخطيط ميداني",),
                        SettingDataCard("المستوى", "السابع",),
                        SettingDataCard("المعدل", "4.62",),
                      ],
                    ),
                    DepContainer(
                      "بيانات السكن",
                      children: [
                        SettingDataCard("نوع السكن", "سكن جامعي",),
                        SettingDataCard("المبنى", "16",),
                        SettingDataCard("الدور", "4",),
                        SettingDataCard("الجناح", "2",),
                        SettingDataCard("غرفة", "7",),
                      ],
                    ),
                    DepContainer(
                      "بيانات الأسرة",
                      children: [
                        SettingDataCard("هل الأسرة بالسعودية", "نعم",),
                        SettingDataCard("عدد أفراد الأسرة", "4", visibility: false,),
                      ],
                    ),
                    DepContainer(
                      "بيانات التواصل",
                      children: [
                        SettingDataCard("رقم الجوال", "نعم",),
                        SettingDataCard("الموقع بالبلد الأم", "4",),
                        SettingDataCard("رقم التواصل بالبلد الأهم", "4",),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class DepContainer extends StatelessWidget {
  DepContainer(this.label, {this.children});

  String label;
  List <SettingDataCard>children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5,),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20,),
            boxShadow: [
              BoxShadow(
                color: color.darkGrey.withOpacity(0.1,),
                blurRadius: 5,
                spreadRadius: 5,
              )
            ]),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20, top: 5,),
              child: Container(
                width: double.infinity,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      label,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                    )),
              ),
            ),
            Column(
              children: children,
            )
          ],
        ),
      ),
    );
  }
}

class SettingDataCard extends StatelessWidget {
  SettingDataCard(this.label, this.data, {this.onPress = null, this.visibility=true});

  String label;
  String data;
  Function onPress;
  bool visibility;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10,),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(label,
                  style: TextStyle(color: color.darkGrey, fontSize: 14,),),),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data,
                      style: TextStyle(color: color.primaryColor, fontSize: 18,),
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.edit,
                    ),
                    onTap: onPress,
                  ),
                ],
              ),
              Divider(color: color.darkGrey, thickness: 0.5,),
            ],
          ),
        ),
      ),
    );
  }
}