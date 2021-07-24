import 'package:flutter/material.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:ksu_scholarship/constant/order_types.dart';
import 'package:ksu_scholarship/problem_domain/Algorithm.dart';
import 'package:ksu_scholarship/problem_domain/models/food_supply_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FoodSupplyOrderScreen extends StatefulWidget {
  static const String id="food_supply_order_screen";


  @override
  _FoodSupplyOrderScreenState createState() => _FoodSupplyOrderScreenState();
}

class _FoodSupplyOrderScreenState extends State<FoodSupplyOrderScreen> {
  @override

  List<String> housingItemList=['مستجد لم يصدر له الرقم الجامعي','منتظم','متخرج ولديه قبول لمرحلة أعلى','مؤجل هذا الفصل ويواصل الفصل القادم','مفصول أكاديميا ولديه موافقة على إكمال البرنامج','متخرج خلال الفصل الدراسي الحالي'];
  String housingchoose;
  TextEditingController noteController=TextEditingController();

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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10,),
                  child: Container(
                    width: double.infinity,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        OrderType().foodSupply,
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
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30,bottom: 20),
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
                              hint: Text(housingchoose==null?"الحالة":housingchoose,),
                              icon: Icon(Icons.arrow_drop_down, size: 30,),
                              isExpanded: true,
                              value: housingchoose,
                              onChanged: (value){
                                setState(() {
                                  housingchoose=value;
                                });
                              },
                              items: housingItemList.map((valueItem){
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
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
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
                        FoodSupplyOrder fs=FoodSupplyOrder("", FirebaseAuth.instance.currentUser.uid, "44000000","student name", "sudan",Timestamp.now(),"proceed",null,noteController.text,null ,null,housingchoose);
                        uploadFoodSupplyOrder(fs);
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