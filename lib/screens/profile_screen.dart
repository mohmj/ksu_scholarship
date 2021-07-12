import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ksu_scholarship/problem_domain/models/housing_order.dart';
import 'package:ksu_scholarship/problem_domain/Algorithm.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "profile_screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List ordersList = [
    {
      'title': "طلب اسكان",
      'date': "1/1/2022",
      'status': "approved",
    },
    {
      'title': "طلب تأشيرة خروج وعودة",
      'date': "2/1/2022",
      'status': "denied",
    },
    {
      'title': "طلب تغذية",
      'date': "3/1/2022",
      'status': "proceed",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
    {
      'title': "طلب إعانة",
      'date': "4/1/2022",
      'status': "error",
    },
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
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: AutoSizeText(
                            "محمد بن علي بن خالد",
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
                            "كلية علوم الحاسب والمعلومات",
                            minFontSize: 24,
                            maxLines: 2,
                            style: TextStyle(
                              color: color.darkGrey,
                            ),
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: AutoSizeText(
                            "م 46 د 4 ج 3 غ 5",
                            minFontSize: 24,
                            maxLines: 2,
                            style: TextStyle(
                              color: color.darkGrey,
                            ),
                          )),
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
                )),
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
                          child: Text("جاري تجميل البيانات"),
                        ),
                      );
                    }else if(!snapshot.hasData){
                      return Container(
                          child: Center(
                          child: Text("جاري تجميل البيانات"),
                    ),
                      );
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (_,index){
                            DocumentSnapshot _orderData=snapshot.data[index];
                           return LastOrderCard(HousingOrder.fromMap(_orderData.data()));
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

  HousingOrder housingOrder;

  Icon _stateIcon(String status) {
    if (status == "approved")
      return Icon(Icons.done, color: color.green);
    else if (status == "denied")
      return Icon(Icons.close, color: color.red);
    else if (status == "proceed")
      return Icon(FontAwesomeIcons.circleNotch, color: color.primaryColor);
    return Icon(
      Icons.error_outline,
      color: Colors.yellow[600],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LastOrderDetails(
                        housingOrder.orderType,
                        "housingOrder.orderDate.toDate().year.toString()",
                        housingOrder.status,
                        notes: housingOrder.note,
                      )));
        },
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
                                    "a",
                                    // "${housingOrder.orderDate.toDate().year}",
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
    );
  }
}

class LastOrderDetails extends StatelessWidget {
  LastOrderDetails(this.title, this.date, this.status, {this.notes = ""});

  String title;
  String date;
  String status;
  String notes;

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
                        title,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
