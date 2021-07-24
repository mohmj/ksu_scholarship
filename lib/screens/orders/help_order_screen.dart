import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:ksu_scholarship/problem_domain/models/housing_order.dart';
import 'package:ksu_scholarship/problem_domain/Algorithm.dart';
import 'package:ksu_scholarship/constant/order_type_enum.dart';


class HelpOrderScreen extends StatefulWidget {
  static const String id="help_order_screen";
  @override
  _HelpOrderScreenState createState() => _HelpOrderScreenState();
}

class _HelpOrderScreenState extends State<HelpOrderScreen> {
  @override
  List<String> typeItemList=['علاج','مساعدة أسرية','دين','متطلبات دراسية'];
  String typeChoose;
  TextEditingController noteController=TextEditingController();
  TextEditingController orderController=TextEditingController();

  Widget build(BuildContext context) {
    orderController.text="أرغب من سعادتكم المساعدة في...";
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
                        "إعانة طالب دراسة حالة",
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
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 30,),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: orderController,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            labelText: "تفاصيل الطلب",
                            hintText: "أرغب من سعاتكم المساعدة في",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey[700],
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: color.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[700],
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(typeChoose==null?"نوع الطلب":typeChoose,),
                              icon: Icon(Icons.arrow_drop_down, size: 30,),
                              isExpanded: true,
                              value: typeChoose,
                              onChanged: (value){
                                setState(() {
                                  typeChoose=value;
                                });
                              },
                              items: typeItemList.map((valueItem){
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: RichText(
                            text: TextSpan(
                              text: "الملفات\n",
                              style: TextStyle(color: color.darkGrey, fontSize: 20, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: "قم بتحميل الملفات جميعا بملف PDF واحد\n مثل الإقامة والتزكية وما يبين الإحتياج",
                                  style: TextStyle(color: color.red, fontSize: 12,),

                                ),
                              ]
                            ),
                          ),
                        ),
                        InkWell(
                          child: Icon(FontAwesomeIcons.filePdf, size: 40,),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 20),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.justify,
                          controller: noteController,
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            labelText: "الملاحظات",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey[700],
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: color.primaryColor,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: double.infinity,
                        // height: 30,
                        margin: EdgeInsets.only(top: 20, bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: color.primaryColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                            child: Text(
                              "ارسال الطلب",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
