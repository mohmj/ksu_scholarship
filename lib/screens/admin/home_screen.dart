import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:ksu_scholarship/constant/housing_types.dart';
import 'package:ksu_scholarship/constant/order_status.dart';
import 'package:ksu_scholarship/constant/order_types.dart';

// import 'package:ksu_scholarship/constant/order_type_enum.dart';
import 'package:ksu_scholarship/problem_domain/Algorithm.dart';
import 'package:ksu_scholarship/problem_domain/models/Account.dart';
import 'package:ksu_scholarship/problem_domain/models/order.dart';

class AdminHomeScreen extends StatefulWidget {
  static const String id = "admin_home_screen";

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
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
                  future: retrieveOrdersAdmins(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        child: Center(
                          child: Text("جاري تحميل البيانات"),
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return Container(
                        child: Center(
                          child: Text("لا توجد طلبات سابقة"),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            DocumentSnapshot _orderData = snapshot.data[index];
                            return LastOrderCard(
                                Order.fromMap(_orderData.data()));
                          });
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
                  builder: (context) => LastOrderDetails(housingOrder)));
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

class LastOrderDetails extends StatefulWidget {
  LastOrderDetails(this._order);

  Order _order;

  Container data({String title, String text}) {
    return Container(
      width: double.infinity,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: title,
                  style: TextStyle(
                      color: color.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: text,
                  style: TextStyle(
                    color: color.darkGrey,
                    fontSize: 16,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  _LastOrderDetailsState createState() => _LastOrderDetailsState();
}

class _LastOrderDetailsState extends State<LastOrderDetails> {
  @override
  bool personalInformation = false;

  Color wrongColor = Colors.white;
  Color deniedColor = Colors.white;
  Color approvedColor = Colors.white;

  String status = "proceed";

  Color statusButtonColorChange(String status) {
    setState(() {
      if (status == "wrong") {
        wrongColor = Colors.orange[500];
        deniedColor = Colors.white;
        approvedColor = Colors.white;
        return Colors.orange[500];
      } else if (status == "approved") {
        wrongColor = Colors.white;
        deniedColor = Colors.white;
        approvedColor = Colors.green[500];
        return Colors.green[500];
      } else if (status == "denied") {
        wrongColor = Colors.white;
        deniedColor = Colors.red[500];
        approvedColor = Colors.white;
        return Colors.red[500];
      } else {
        wrongColor = Colors.white;
        deniedColor = Colors.white;
        approvedColor = Colors.white;
        return Colors.white;
      }
    });
  }

  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  bool gender = false; // false is male and true is female
  TextEditingController nationalityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  Timestamp birthDay;
  TextEditingController birthController = TextEditingController();
  TextEditingController iqamaNumberController = TextEditingController();
  Timestamp iqamaExpDate;
  TextEditingController iqamaExpDateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController universityIdController = TextEditingController();
  TextEditingController GPAController = TextEditingController();
  String degree;
  List<String> degreeList = [
    "دكتوراه",
    "ماجستير",
    "بكالوريوس",
    "السنة التحضيرية",
    "دبلوم عالي",
    "دبلوم"
  ];
  TextEditingController collegeController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  List<String> academicStatusList = [
    'منتظم',
    'متخرج',
    'معتذر',
    'مؤجل',
    'مفصول أكاديميا'
  ];
  String academicStatus;
  List<String> housingTypeList = [
    HousingTypes().universityHousing,
    HousingTypes().charitable,
    HousingTypes().rent
  ];
  String housingType;
  int houseBuilding = 0;
  int houseFloor = 0;
  int houseSuite = 0;
  int houseRoom = 0;
  bool familyInSaudiArabia = false;
  int numberOfFamilyMember = 0;
  TextEditingController addressInCountryController = TextEditingController();
  TextEditingController contactNumberInCountryController =
      TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                        widget._order.orderType,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        personalInformation = true;
                      });
                    },
                    child: Column(
                      children: [
                        Expanded(
                            child: Center(child: Text("البيانات الشخصية"))),
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: personalInformation
                              ? color.primaryColor
                              : Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        personalInformation = false;
                      });
                    },
                    child: Column(
                      children: [
                        Expanded(child: Center(child: Text("بيانات الطلب"))),
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: personalInformation
                              ? Colors.grey
                              : color.primaryColor,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: !personalInformation,
            child: Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            widget.data(
                                title: "تاريخ الطلب: ", text: "0000/00/00"),
                            widget.data(title: "وقت الطلب: ", text: "00:00"),
                            widget.data(
                                title: "حالة الطلب: ", text: "2002/02/02"),
                            Visibility(
                              visible: widget._order.studentNote == null ||
                                      widget._order.studentNote.isEmpty ||
                                      widget._order.studentNote == ""
                                  ? false
                                  : true,
                              child: widget.data(
                                  title: "الملاحظات:  ",
                                  text: widget._order.studentNote),
                            ),
                            Visibility(
                              visible: widget._order.orderStatus ==
                                  OrderStatus().proceed,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: InkWell(
                                  child: Icon(FontAwesomeIcons.filePdf,
                                      color: color.primaryColor, size: 40),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: widget._order.orderStatus ==
                                  OrderStatus().proceed,
                              child: Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            status = "wrong";
                                            statusButtonColorChange(status);
                                          });
                                        },
                                        child: Container(
                                          width: 75,
                                          decoration: BoxDecoration(
                                              color: wrongColor,
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              border: Border.all(
                                                  color: Colors.orange[500],
                                                  width: 3)),
                                          child: Center(
                                            child: Text(
                                              'تعذر',
                                              style: TextStyle(
                                                  color: status == "wrong"
                                                      ? Colors.white
                                                      : Colors.grey[700],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            status = "denied";
                                            statusButtonColorChange(status);
                                          });
                                        },
                                        child: Container(
                                          width: 75,
                                          decoration: BoxDecoration(
                                              color: deniedColor,
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              border: Border.all(
                                                  color: Colors.red[500],
                                                  width: 3)),
                                          child: Center(
                                            child: Text(
                                              'رفض',
                                              style: TextStyle(
                                                  color: status == "denied"
                                                      ? Colors.white
                                                      : Colors.grey[700],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            status = "approved";
                                            statusButtonColorChange(status);
                                          });
                                        },
                                        child: Container(
                                          width: 75,
                                          decoration: BoxDecoration(
                                              color: approvedColor,
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              border: Border.all(
                                                  color: Colors.green[500],
                                                  width: 3)),
                                          child: Center(
                                            child: Text(
                                              'قبول',
                                              style: TextStyle(
                                                  color: status == "approved"
                                                      ? Colors.white
                                                      : Colors.grey[700],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: widget._order.orderStatus ==
                                    OrderStatus().proceed,
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: widget._order.orderType ==
                                              OrderType().housing
                                          ? true
                                          : false,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 0,
                                          top: 30,
                                        ),
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextField(
                                            keyboardType: TextInputType.text,
                                            // controller: whereToController,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                            decoration: InputDecoration(
                                              labelText: "مدة البقاء",
                                              helperText:
                                                  "إذا كان الطالب متخرج خلال الفصل الحالي فقط، إن لم يكن اتركه فارغا",
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                  color: Colors.grey[700],
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                  color: color.primaryColor,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 0, top: 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          keyboardType: TextInputType.text,
                                          textAlign: TextAlign.justify,
                                          // controller: noteController,
                                          maxLines: 5,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "الملاحظات",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                color: Colors.grey[700],
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                color: color.primaryColor,
                                                width: 2,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Visibility(
                              visible: widget._order.orderStatus !=
                                      OrderStatus().proceed
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Divider(
                                        color: color.darkGrey,
                                        height: 4,
                                        thickness: 1,
                                      ),
                                    ),
                                  ),
                                  widget.data(
                                      title: "تاريخ الرد: ",
                                      text: "0000/00/00"),
                                  widget.data(
                                      title: "وقت الرد: ", text: "00:00"),
                                  Visibility(
                                    visible: widget._order.note == null ||
                                            widget._order.note.isEmpty ||
                                            widget._order.note == ""
                                        ? false
                                        : true,
                                    child: widget.data(
                                        title: "الملاحظات:  ",
                                        text: widget._order.note),
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: InkWell(
                                        child: Icon(FontAwesomeIcons.filePdf,
                                            color: color.primaryColor,
                                            size: 40),
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
                                  margin: EdgeInsets.only(top: 20, bottom: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: color.primaryColor,
                                  ),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Center(
                                          child: Text(
                                        "رفع",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ))),
                                ),
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: personalInformation,
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 30,
                  left: 20,
                  right: 20,
                ),
                child: FutureBuilder(
                  future: retrieveUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        child: Center(
                          child: Text("جاري جلب البيانات"),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            DocumentSnapshot _doc = snapshot.data[index];
                            Account _account = Account.fromMap(_doc.data());
                            bool houseDetails = _account.housingType ==
                                    HousingTypes().universityHousing
                                ? true
                                : false;
                            nameArController.text = _account.nameAr;
                            nameEnController.text = _account.nameEn;
                            nationalityController.text = _account.nationality;
                            countryController.text = _account.country;
                            birthDay = _account.dateOfBirth;
                            birthController.text =
                                "${_account.dateOfBirth.toDate().year}/${_account.dateOfBirth.toDate().month}/${_account.dateOfBirth.toDate().day}";
                            iqamaNumberController.text = _account.iqamaNumber;
                            iqamaExpDate = _account.iqamaExpireDate;
                            iqamaExpDateController.text =
                                "${_account.iqamaExpireDate.toDate().year}/${_account.iqamaExpireDate.toDate().month}/${_account.iqamaExpireDate.toDate().day}";
                            universityIdController.text = _account.universityID;
                            degree = _account.degree;
                            collegeController.text = _account.college;
                            departmentController.text = _account.department;
                            levelController.text = _account.level.toString();
                            GPAController.text = _account.GPA.toString();
                            housingType = _account.housingType;
                            houseBuilding = _account.houseBuilding;
                            houseFloor = _account.houseFloor;
                            houseSuite = _account.houseSuite;
                            houseRoom = _account.houseRoom;
                            familyInSaudiArabia = _account.familyInSaudiArabia;
                            numberOfFamilyMember = _account.numberOfFamily;
                            phoneNumberController.text = _account.phoneNumber;
                            addressInCountryController.text =
                                _account.addressInCountry;
                            contactNumberInCountryController.text =
                                _account.phoneInCountry;
                            return Column(
                              children: [
                                DepContainer(
                                  "البيانات الشخصية",
                                  children: [
                                    SettingDataCard(
                                      "الاسم",
                                      _account.nameAr,
                                    ),
                                    SettingDataCard(
                                      "الاسم باللغة الانجليزية",
                                      _account.nameEn,
                                    ),
                                    SettingDataCard(
                                      "الجنسية",
                                      _account.nationality,
                                    ),
                                    SettingDataCard(
                                      "البلد",
                                      _account.country,
                                    ),
                                    SettingDataCard(
                                      "تاريخ الميلاد",
                                      "${_account.dateOfBirth.toDate().year}/${_account.dateOfBirth.toDate().month}/${_account.dateOfBirth.toDate().day}",
                                      buttonVis: false,
                                    ),
                                  ],
                                ),
                                DepContainer(
                                  "بيانات الهوية",
                                  children: [
                                    SettingDataCard(
                                        "رقم الهوية", _account.iqamaNumber),
                                    SettingDataCard(
                                      "تاريخ انتهاء الهوية",
                                      "${_account.iqamaExpireDate.toDate().year}/${_account.iqamaExpireDate.toDate().month}/${_account.iqamaExpireDate.toDate().day}",
                                    ),
                                    // SettingDataCard("رقم الجواز", "16",),
                                    // SettingDataCard("تاريخ انتهاء الجواز", "2",),
                                  ],
                                ),
                                DepContainer(
                                  "البيانات الأكاديمية",
                                  children: [
                                    SettingDataCard(
                                      "الرقم الجامعي",
                                      _account.universityID,
                                    ),
                                    SettingDataCard(
                                      "الدرجة العلمية",
                                      _account.degree,
                                    ),
                                    SettingDataCard("الكلية", _account.college),
                                    SettingDataCard(
                                      "التخصص",
                                      _account.department,
                                    ),
                                    SettingDataCard(
                                      "المستوى",
                                      _account.level.toString(),
                                    ),
                                    SettingDataCard(
                                      "المعدل",
                                      _account.GPA.toString(),
                                    ),
                                  ],
                                ),
                                DepContainer(
                                  "بيانات السكن",
                                  children: [
                                    SettingDataCard(
                                      "نوع السكن",
                                      _account.housingType,
                                    ),
                                    SettingDataCard(
                                      "المبنى",
                                      _account.houseBuilding.toString(),
                                      visibility: houseDetails,
                                    ),
                                    SettingDataCard(
                                      "الدور",
                                      _account.houseFloor.toString(),
                                      visibility: houseDetails,
                                    ),
                                    SettingDataCard(
                                      "الجناح",
                                      _account.houseSuite.toString(),
                                      visibility: houseDetails,
                                    ),
                                    SettingDataCard(
                                      "غرفة",
                                      _account.houseRoom.toString(),
                                      visibility: houseDetails,
                                    ),
                                  ],
                                ),
                                DepContainer(
                                  "بيانات الأسرة",
                                  children: [
                                    SettingDataCard(
                                      "هل الأسرة بالسعودية",
                                      _account.familyInSaudiArabia
                                          ? "نعم"
                                          : "لا",
                                    ),
                                    SettingDataCard(
                                      "عدد أفراد الأسرة",
                                      _account.numberOfFamily.toString(),
                                      visibility: _account.familyInSaudiArabia,
                                    ),
                                  ],
                                ),
                                DepContainer(
                                  "بيانات التواصل",
                                  children: [
                                    SettingDataCard(
                                      "رقم الجوال",
                                      _account.phoneNumber,
                                    ),
                                    SettingDataCard(
                                      "العنوان بالبلد الأم",
                                      _account.addressInCountry,
                                    ),
                                    SettingDataCard(
                                      "رقم التواصل بالبلد الأم",
                                      _account.phoneInCountry,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DepContainer extends StatelessWidget {
  DepContainer(this.label, {this.children});

  String label;
  List<SettingDataCard> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              20,
            ),
            boxShadow: [
              BoxShadow(
                color: color.darkGrey.withOpacity(
                  0.1,
                ),
                blurRadius: 5,
                spreadRadius: 5,
              )
            ]),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
                top: 5,
              ),
              child: Container(
                width: double.infinity,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
  SettingDataCard(this.label, this.data,
      {this.onPress = null, this.visibility = true, this.buttonVis = false});

  String label;
  String data;
  Function onPress;
  bool visibility;
  bool buttonVis;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  label,
                  style: TextStyle(
                    color: color.darkGrey,
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data,
                      style: TextStyle(
                        color: color.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: buttonVis,
                    child: InkWell(
                      child: Icon(
                        Icons.edit,
                      ),
                      onTap: onPress,
                    ),
                  ),
                ],
              ),
              // Divider(color: color.darkGrey, thickness: 0.5,),
              Container(
                margin: EdgeInsets.only(top: 5),
                color: color.darkGrey.withOpacity(0.6),
                height: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
