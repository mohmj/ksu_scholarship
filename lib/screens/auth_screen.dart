import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ksu_scholarship/problem_domain/models/Account.dart';
import 'package:ksu_scholarship/problem_domain/Algorithm.dart';
import 'package:ksu_scholarship/screens/home_screen.dart';
import 'package:ksu_scholarship/screens/mother_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String id = "auth_screen";

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override

  // Controllers
  TextEditingController nameArController=TextEditingController();
  TextEditingController nameEnController=TextEditingController();
  bool gender=false; // false is male and true is female
  TextEditingController nationalityController=TextEditingController();
  TextEditingController countryController=TextEditingController();
  Timestamp birthDay;
  TextEditingController birthController=TextEditingController();
  TextEditingController iqamaNumberController=TextEditingController();
  Timestamp iqamaExpDate;
  TextEditingController iqamaExpDateController=TextEditingController();
  TextEditingController phoneNumberController=TextEditingController();
  TextEditingController universityIdController=TextEditingController();
  TextEditingController GPAController=TextEditingController();
  String degree;
  List<String> degreeList=["دكتوراه","ماجستير","بكالوريوس","السنة التحضيرية","دبلوم عالي","دبلوم"];
  TextEditingController collegeController=TextEditingController();
  TextEditingController departmentController=TextEditingController();
  TextEditingController levelController=TextEditingController();
  List<String> academicStatusList=['منتظم','متخرج','معتذر','مؤجل','مفصول أكاديميا'];
  String academicStatus;
  List<String> housingTypeList=['سكن الجامعة','سكن خيري','سكن بالإيجار'];
  String housingType;
  bool familyInSaudiArabia=false;
  int numberOfFamilyMember=0;
  TextEditingController addressInCountryController=TextEditingController();
  TextEditingController contactNumberInCountryController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();

  // End of controllers.
  TextEditingController _IqamaExpDateController=TextEditingController();

  // Login controllers
  TextEditingController loginEmailController=TextEditingController();
  TextEditingController loginPasswordController=TextEditingController();



  String blueButtonText="تسجيل الدخول";
  String whiteButtonText="التسجيل";


  bool loginVisibility=true;
  bool regVisibility=false;
  bool getPassVisibility=false;


  AuthWidgets correctAuthWidget=AuthWidgets.login;

  void changeWidget(AuthWidgets choose){
    setState(() {
      if(choose==AuthWidgets.resetPassword){
        loginVisibility=false;
        regVisibility=false;
        getPassVisibility=true;
        blueButtonText="استعادة كلمة السر";
        whiteButtonText="تسجيل الدخول";
      }else if(choose==AuthWidgets.registration){
        loginVisibility=false;
        regVisibility=true;
        getPassVisibility=false;
        blueButtonText="التسجيل";
        whiteButtonText="تسجيل الدخول";
      }else {
        loginVisibility=true;
        regVisibility=false;
        getPassVisibility=false;
        blueButtonText="تسجيل الدخول";
        whiteButtonText="التسجيل";
      }
    });
  }

  // Controllers
  TextEditingController gradeController=TextEditingController();
  String checkGrade(double grade){
    if(grade >=0 && grade <=5) return null;
    return "يجب أن يكون المعدل بين 0 و 5";
  }

  Widget build(BuildContext context) {
    loginEmailController.text="@student.ksu.edu.sa";

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03),
                  child: Image(
                    image: AssetImage("assets/KSU_logo.png"),
                  )),
              Expanded(
                child: Center(
                  child: ListView(
                    children: [
                      Visibility(
                        visible: loginVisibility,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10, top: 50),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: loginEmailController,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  labelText: "البريد الإلكتروني",
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
                            padding: EdgeInsets.only(bottom: 5),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: loginPasswordController,
                                obscureText: true,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  labelText: "كلمة السر",
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
                          InkWell(
                            child: Container(
                              width: double.infinity,
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text("نسيت كلمة السر")),
                            ),
                            onTap: (){
                              setState(() {
                                correctAuthWidget=AuthWidgets.resetPassword;
                                changeWidget(correctAuthWidget);
                              });
                            },
                          ),
                        ],),
                      ),
                      Visibility(visible: getPassVisibility,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10, top: 50),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: false, decimal: false),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  labelText: "الرقم الجامعي",
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
                        ],),
                      ),
                      Visibility(
                        visible: regVisibility,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 20),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: nameArController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "الاسم باللغة العربية",
                                    helperText: "كما يظهر في الاقامة",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: nameEnController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "الاسم باللغة الانجليزية",
                                    helperText: "كما يظهر في جواز السفر",
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
                              padding: EdgeInsets.only(bottom: 10),
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
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Column(
                                        children: [
                                          Container(
                                              width:double.infinity,
                                              child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: Text("الجنس", style: TextStyle(fontSize: 20),))),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: false,
                                                      groupValue: gender,
                                                      focusColor: color.primaryColor,
                                                      onChanged: (value){
                                                        setState(() {
                                                          gender=value;
                                                        });
                                                      },
                                                    ),
                                                    Text("ذكر"),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: true,
                                                      groupValue: gender,
                                                      focusColor: color.primaryColor,
                                                      onChanged: (value){
                                                        setState(() {
                                                          gender=value;
                                                        });
                                                      },
                                                    ),
                                                    Text("أنثى"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: nationalityController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "الجنسية",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: countryController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "البلد",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.datetime,
                                  controller: birthController,
                                  onTap:(){
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(DateTime.now().year-80),
                                      lastDate: DateTime(DateTime.now().year+2),
                                    ).then((pickedDate) {
                                      birthDay=Timestamp.fromDate(pickedDate);
                                      setState(() {
                                        birthController.text="${birthDay.toDate().year}/${birthDay.toDate().month}/${birthDay.toDate().day}";
                                      });
                                    });
                                  },
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "تاريخ الميلاد",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                                  controller: iqamaNumberController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "رقم الإقامة",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.datetime,
                                  controller: _IqamaExpDateController,
                                  onTap:(){
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(DateTime.now().year),
                                      lastDate: DateTime(DateTime.now().year+2),
                                    ).then((pickedDate) {
                                      iqamaExpDate=Timestamp.fromDate(pickedDate);
                                      print(iqamaExpDate.toDate().month);
                                      setState(() {
                                        _IqamaExpDateController.text="${iqamaExpDate.toDate().year}/${iqamaExpDate.toDate().month}/${iqamaExpDate.toDate().day}";
                                      });
                                    });
                                  },
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "تاريخ انتهاء الاقامة",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                                  controller: phoneNumberController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "رقم الجوال",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                                  controller: universityIdController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "الرقم الجامعي",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: GPAController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "المعدل التراكمي",
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
                                    errorText: gradeController.text.isNotEmpty?checkGrade(double.parse(gradeController.text.toString())):null,
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
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
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
                                      hint: Text(degree==null?"الدرجة العلمية":degree,),
                                      icon: Icon(Icons.arrow_drop_down, size: 30,),
                                      isExpanded: true,
                                      value: degree,
                                      onChanged: (value){
                                        setState(() {
                                          degree=value;
                                        });
                                      },
                                      items: degreeList.map((valueItem){
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
                            //
                            //         DropdownButtonFormField(
                            //           decoration: InputDecoration(
                            //               border: OutlineInputBorder(
                            //                 borderRadius: const BorderRadius.all(
                            //                   const Radius.circular(30.0),
                            //                 ),
                            //               ),
                            //               filled: true,
                            //               hintStyle: TextStyle(color: Colors.grey[800]),
                            //               hintText: "Name",
                            //               fillColor: Colors.blue[200]),
                            //           value: dropDownValue,
                            //           onChanged: (String Value) {
                            //             setState(() {
                            //               dropDownValue = Value;
                            //             });
                            //           },
                            //           items: cityList
                            //               .map((cityTitle) => DropdownMenuItem(
                            //               value: cityTitle, child: Text("$cityTitle")))
                            //               .toList(),
                            //         ),
                            //       ],
                            //     ),
                            // ),
                            // floatingActionButton: FloatingActionButton(
                            //   onPressed: _incrementCounter,
                            //   tooltip: 'Increment',
                            //   child: Icon(Icons.add),
                            // ),

                            // DropdownButton<String>(
                            //   isExpanded: true,
                            //   items: <String>['بكالوريوس', 'ماجستير', 'دكتوراه', 'دبلوم'].map((String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: new Text(value),
                            //     );
                            //   }).toList(),
                            //   onChanged: (a) {
                            //     setState(() {
                            //     });
                            //   },
                            // ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: collegeController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "الكلية",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: departmentController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "القسم",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                                  controller: levelController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "المستوى الدراسي",
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
                              padding: EdgeInsets.only(bottom: 10),
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
                                      hint: Text(academicStatus==null?"الحالة الأكاديمية":academicStatus,),
                                      icon: Icon(Icons.arrow_drop_down, size: 30,),
                                      isExpanded: true,
                                      value: academicStatus,
                                      onChanged: (value){
                                        setState(() {
                                          academicStatus=value;
                                        });
                                      },
                                      items: academicStatusList.map((valueItem){
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
                                      hint: Text(housingType==null?"نوع السكن":housingType,),
                                      icon: Icon(Icons.arrow_drop_down, size: 30,),
                                      isExpanded: true,
                                      value: housingType,
                                      onChanged: (value){
                                        setState(() {
                                          housingType=value;
                                        });
                                      },
                                      items: housingTypeList.map((valueItem){
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
                            Visibility(
                                visible: housingType=="سكن الجامعة"?true:false,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          keyboardType: TextInputType.numberWithOptions(decimal: false),
                                          controller: departmentController,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "رقم المبنى",
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
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          keyboardType: TextInputType.numberWithOptions(decimal: false),
                                          controller: departmentController,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "رقم الدور",
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
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          keyboardType: TextInputType.numberWithOptions(decimal: false),
                                          controller: departmentController,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "رقم الجناح",
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
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          keyboardType: TextInputType.numberWithOptions(decimal: false),
                                          controller: departmentController,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "رقم الغرفة",
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

                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
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
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Column(
                                        children: [
                                          Container(
                                              width:double.infinity,
                                              child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: Text("هل عائلتك في السعودية", style: TextStyle(fontSize: 20),))),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: true,
                                                      groupValue: familyInSaudiArabia,
                                                      focusColor: color.primaryColor,
                                                      onChanged: (value){
                                                        setState(() {
                                                          familyInSaudiArabia=value;
                                                        });
                                                      },
                                                    ),
                                                    Text("نعم"),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: false,
                                                      groupValue: familyInSaudiArabia,
                                                      focusColor: color.primaryColor,
                                                      onChanged: (value){
                                                        setState(() {
                                                          familyInSaudiArabia=value;
                                                        });
                                                      },
                                                    ),
                                                    Text("لا"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                            Visibility(
                              visible: familyInSaudiArabia,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                                    onChanged: (value){
                                      if(value.isEmpty){
                                        numberOfFamilyMember=0;
                                      }else{
                                        numberOfFamilyMember=int.parse(value);
                                      }
                                    },
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: "عدد أفراد العائلة",
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
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: addressInCountryController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "العنوان في البلد",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                                  controller: contactNumberInCountryController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "رقم التواصل في البلد",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  obscureText: true,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "كلمة المرور",
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
                              padding: EdgeInsets.only(bottom: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: confirmPasswordController,
                                  obscureText: true,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "تأكيد كلمة المرور",
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
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
                                blueButtonText,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ))),
                    ),
                    onTap: ()async{
                      if(regVisibility){
                        UserCredential _userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: universityIdController.text.trim()+"@student.ksu.edu.sa", password: passwordController.text);
                        User _user=_userCredential.user;
                        Account _account=Account(_user.uid, false, false,universityIdController.text.trim(),nameArController.text.trim(), nameEnController.text.trim(),
                        _user.email,gender,nationalityController.text.trim(), countryController.text.trim(),birthDay,iqamaNumberController.text.trim(),iqamaExpDate,phoneNumberController.text.trim(),
                          double.parse(GPAController.text.trim()),degree, collegeController.text.trim(), departmentController.text.trim(), int.parse(levelController.text.trim()),
                          academicStatus,housingType,familyInSaudiArabia,numberOfFamilyMember,addressInCountryController.text.trim(),contactNumberInCountryController.text.trim()
                        );
                        if(_user != null){
                          uploadUser(_account);
                          Navigator.pushReplacementNamed(context, MotherScreen.id);
                        }
                      }else if(loginVisibility){
                        UserCredential _userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginEmailController.text.trim(), password: loginPasswordController.text);
                        if(_userCredential.user != null){
                          Navigator.popAndPushNamed(context, MotherScreen.id);
                        }
                      }else{
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: loginEmailController.text.trim());
                        setState(() {
                          changeWidget(AuthWidgets.resetPassword);
                        });
                      }
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: double.infinity,
                      // height: 30,
                      margin: EdgeInsets.only(top: 0, bottom: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: color.primaryColor, width: 2)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Center(
                          child: Text(
                            whiteButtonText,
                            style: TextStyle(
                                color: color.primaryColor, fontSize: 20),
                          ),),),
                    ),
                    onTap: (){
                      setState(() {
                        if(loginVisibility){
                          correctAuthWidget=AuthWidgets.registration;
                          changeWidget(correctAuthWidget);
                        }else{
                          correctAuthWidget=AuthWidgets.login;
                          changeWidget(correctAuthWidget);
                        }
                      });
                    },
                  ),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}

enum AuthWidgets{
  login,registration,resetPassword
}