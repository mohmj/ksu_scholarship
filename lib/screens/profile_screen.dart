import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ksu_scholarship/constant/housing_types.dart';
import 'package:ksu_scholarship/problem_domain/models/Account.dart';
import 'package:ksu_scholarship/problem_domain/models/housing_order.dart';
import 'package:ksu_scholarship/problem_domain/models/order.dart';
import 'package:ksu_scholarship/problem_domain/Algorithm.dart';
import 'package:ksu_scholarship/constant/order_status.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "profile_screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


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
                        "الملف الشخصي",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Container(
                width: double.infinity,
                height: 125,
                child: FutureBuilder(
                  future: retrieveUserData(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Container(
                        child: Center(
                          child: Text("جاري جلب البيانات"),
                        ),
                      );
                    }else{
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_,index){
                            DocumentSnapshot _userData=snapshot.data[index];
                            Account _userDataMap=Account.fromMap(_userData.data());
                            return Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: AutoSizeText(
                                        _userDataMap.nameAr,
                                        minFontSize: 32,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: color.primaryColor,
                                        ),
                                      )),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: AutoSizeText(
                                        _userDataMap.college,
                                        minFontSize: 24,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: color.darkGrey,
                                        ),
                                      )),
                                ),
                                Visibility(
                                  visible: _userDataMap.housingType==HousingTypes().universityHousing?true:false,
                                  child: Container(
                                    width: double.infinity,
                                    child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AutoSizeText(
                                          // " ${_userDataMap.houseRoom} "+"غ"+" ${_userDataMap.houseSuite} "+"ج"+" ${_userDataMap.houseFloor} "+,
                                          "م"+" ${_userDataMap.houseBuilding} "+"د"+" ${_userDataMap.houseFloor} "+"ج"+" ${_userDataMap.houseSuite} "+"غ"+" ${_userDataMap.houseRoom} ",
                                          minFontSize: 24,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: color.darkGrey,
                                          ),
                                        )),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Container(
                                      width: double.infinity,
                                      height: 110,
                                      child: BarcodeWidget(
                                        barcode: Barcode.code128(),
                                        data: '4********',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                      );
                    }
                  },
                )
            ),
          ),
          Container(
            width: double.infinity,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "الطلبات السابقة",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: color.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40, right: 15, left: 15),
              child: Container(
                width: double.infinity,
                // decoration: BoxDecoration(
                //   border: Border.all(
                //       color: color.darkGrey,
                //       width: 2
                //   ),
                //   borderRadius: BorderRadius.circular(20)
                // ),
                child: FutureBuilder(
                  future: retrieveOrders(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Container(
                        child: Center(
                          child: Text("جاري تحميل البيانات"),
                        ),
                      );
                    }else if(!snapshot.hasData){
                      return Container(
                          child: Center(
                          child: Text("لا توجد طلبات سابقة"),
                    ),
                      );
                    }else{
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data.length,
                        itemBuilder: (_,index){
                          DocumentSnapshot _orderData=snapshot.data[index];
                            return LastOrderCard(Order.fromMap(_orderData.data()));
                        }
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LastOrderCard extends StatelessWidget {
  LastOrderCard(this.housingOrder);

  Order housingOrder;

  Icon _stateIcon(String status) {
    if (status == OrderStatus().approved)
      return Icon(Icons.done, color: color.green);
    else if (status == OrderStatus().denied)
      return Icon(Icons.close, color: color.red);
    else if (status == OrderStatus().proceed)
      return Icon(FontAwesomeIcons.circleNotch, color: color.primaryColor);
    return Icon(
      Icons.error_outline,
      color: Colors.yellow[600],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LastOrderDetails(
                        housingOrder
                      )));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_outlined,
                        color: color.primaryColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      housingOrder.orderType,
                                      style: TextStyle(
                                          color: color.primaryColor,
                                          fontSize: 20),
                                    ))),
                            Container(
                                width: double.infinity,
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      // "a",
                                      // "${housingOrder.orderDate.toDate().year}",
                                      "0000/00/00",
                                      style: TextStyle(
                                          color: color.primaryColor,
                                          fontSize: 14),
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      _stateIcon(housingOrder.orderStatus),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Divider(
                      color: color.darkGrey.withOpacity(0.2),
                      thickness: 2,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class LastOrderDetails extends StatelessWidget {
  LastOrderDetails(this._order);

  Order _order;

  Container data({String title, String text}){
    return Container(
      width: double.infinity,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: RichText(text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: title,style: TextStyle(color: color.primaryColor, fontSize: 20, fontWeight: FontWeight.bold)),
            TextSpan(text: text,style: TextStyle(color: color.darkGrey, fontSize: 16, )),
        ],
        ),
        ),
      ),
    );
  }

  // TextSpan title(String text){
  //   return TextSpan(text: text,style: TextStyle(color: color.primaryColor));
  // }
  // TextSpan information(String text){
  //   return TextSpan(text: text,style: TextStyle(color: color.darkGrey));
  // }

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
                        _order.orderType,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                data(title: "تاريخ الطلب: ", text:  "0000/00/00"),
                data(title: "وقت الطلب: ", text: "00:00"),
                data(title: "حالة الطلب: ", text: "2002/02/02"),
                Visibility(
                  visible: _order.studentNote==null || _order.studentNote.isEmpty || _order.studentNote==""?false:true,
                  child: data(title: "الملاحظات:  ", text: _order.studentNote),),
                Visibility(
                  visible: _order.answerDate==null?false:true,
                  child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.6,
                            child: Divider(
                              color: color.darkGrey,
                              height: 4,
                              thickness: 1,
                            ),
                          ),
                        ),
                        data(title: "تاريخ الرد: ", text:  "0000/00/00"),
                        data(title: "وقت الرد: ", text: "00:00"),
                        Visibility(
                          visible: _order.note==null || _order.note.isEmpty || _order.note==""?false:true,
                          child: data(title: "الملاحظات:  ", text: _order.note),),
                        Visibility(
                          visible: true,
                          child:Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: InkWell(
                              child: Icon(FontAwesomeIcons.filePdf, color: color.primaryColor, size: 40),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: InkWell(
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
                                "رجوع",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ))),
                    ),
                    onTap: ()async{
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}