import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:ksu_scholarship/constant/Widgets.dart' as widgets;
import 'package:ksu_scholarship/problem_domain/Algorithm.dart';
import 'package:ksu_scholarship/problem_domain/models/Account.dart';
import 'package:ksu_scholarship/constant/housing_types.dart';
class SettingScreen extends StatefulWidget {
  static const String id = "setting_screen";

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // Account account=Account.first();
  @override
  void initState() {
    // getUserData();
    super.initState();
  }

/*
  getUserData()async{
    DocumentSnapshot _userData=retrieveUserDataDoc();
    account=Account.fromMap(_userData.data());
  }
*/

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
  List<String> housingTypeList=[HousingTypes().universityHousing,HousingTypes().charitable,HousingTypes().rent];
  String housingType;
  int houseBuilding=0; int houseFloor=0; int houseSuite=0; int houseRoom=0;
  bool familyInSaudiArabia=false;
  int numberOfFamilyMember=0;
  TextEditingController addressInCountryController=TextEditingController();
  TextEditingController contactNumberInCountryController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();


  Widget build(BuildContext context) {
    double bottomSheetHeight = 256;

    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      if (visible) {
        print("it's open");
        setState(() {
          bottomSheetHeight = MediaQuery.of(context).size.height * 0.65;
        });
      } else {
        print("closed");
        setState(() {
          bottomSheetHeight = 256;
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
                child: FutureBuilder(
                  future: retrieveUserData(),
                  builder: (context, snapshot){
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
                           DocumentSnapshot _doc=snapshot.data[index];
                           Account _account=Account.fromMap(_doc.data());
                           bool houseDetails=_account.housingType==HousingTypes().universityHousing?true:false;
                           nameArController.text=_account.nameAr;
                           nameEnController.text=_account.nameEn;
                           nationalityController.text=_account.nationality;
                           countryController.text=_account.country;
                           birthDay=_account.dateOfBirth;
                           birthController.text="${_account.dateOfBirth.toDate().year}/${_account.dateOfBirth.toDate().month}/${_account.dateOfBirth.toDate().day}";
                           iqamaNumberController.text=_account.iqamaNumber;
                           iqamaExpDate=_account.iqamaExpireDate;
                           iqamaExpDateController.text="${_account.iqamaExpireDate.toDate().year}/${_account.iqamaExpireDate.toDate().month}/${_account.iqamaExpireDate.toDate().day}";
                           universityIdController.text=_account.universityID;
                           degree=_account.degree;
                           collegeController.text=_account.college;
                           departmentController.text=_account.department;
                           levelController.text=_account.level.toString();
                           GPAController.text=_account.GPA.toString();
                           housingType=_account.housingType;
                           houseBuilding=_account.houseBuilding;
                           houseFloor=_account.houseFloor;
                           houseSuite=_account.houseSuite;
                           houseRoom=_account.houseRoom;
                           familyInSaudiArabia=_account.familyInSaudiArabia;
                           numberOfFamilyMember=_account.numberOfFamily;
                           phoneNumberController.text=_account.phoneNumber;
                           addressInCountryController.text=_account.addressInCountry;
                           contactNumberInCountryController.text=_account.phoneInCountry;
                           return Column(
                             children: [
                               DepContainer(
                                 "البيانات الشخصية",
                                 children: [
                                   SettingDataCard(
                                     "الاسم",
                                     _account.nameAr,
                                     onPress: (){
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
                                                                 "تحديث الاسم",
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
                                                             controller: nameArController,
                                                             style: TextStyle(
                                                               color: color.primaryColor, fontSize: 20,),
                                                             decoration: InputDecoration(
                                                               labelText: "الاسم",
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
                                                           onTap: ()async{
                                                             await updateUserData("nameAr", nameArController.text.trim());
                                                             Navigator.pop(context);
                                                           },
                                                         ),
                                                       ),
                                                     ],
                                                   ));
                                             });
                                           });
                                     },
                                   ),
                                   SettingDataCard(
                                     "الاسم باللغة الانجليزية",
                                     _account.nameEn,
    onPress: () {
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
                                "تحديث الاسم باللغة الإنجليزية",
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
                            controller: nameEnController,
                            style: TextStyle(
                              color: color.primaryColor, fontSize: 20,),
                            decoration: InputDecoration(
                              labelText: "الاسم باللغة الإنجليزية",
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
                          onTap: ()async{
                            await updateUserData("nameEn", nameEnController.text.trim());
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ));
            });
          },
      );
    },
                                   ),
                                   SettingDataCard("الجنسية", _account.nationality, onPress: (){
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
                                                             "تحديث الجنسية",
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
                                                         controller: nationalityController,
                                                         style: TextStyle(
                                                           color: color.primaryColor, fontSize: 20,),
                                                         decoration: InputDecoration(
                                                           labelText: "الجنسية",
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
                                                       onTap: ()async{
                                                         await updateUserData("nationality", nationalityController.text.trim());
                                                         Navigator.pop(context);
                                                       },
                                                     ),
                                                   ),
                                                 ],
                                               ));
                                         });
                                       },
                                     );
                                   },),
                                   SettingDataCard("البلد",_account.country, onPress: (){
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
                                                             "تحديث البلد",
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
                                                         controller: countryController,
                                                         style: TextStyle(
                                                           color: color.primaryColor, fontSize: 20,),
                                                         decoration: InputDecoration(
                                                           labelText: "البلد",
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
                                                       onTap: ()async{
                                                         await updateUserData("country", countryController.text.trim());
                                                         Navigator.pop(context);
                                                       },
                                                     ),
                                                   ),
                                                 ],
                                               ));
                                         });
                                       },
                                     );
                                   },),
                                   SettingDataCard("تاريخ الميلاد", "${_account.dateOfBirth.toDate().year}/${_account.dateOfBirth.toDate().month}/${_account.dateOfBirth.toDate().day}", onPress: (){
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
                                                             "تحديث تاريخ الميلاد",
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
                                                     padding: EdgeInsets.only(bottom: 10, right: 30, left: 30),
                                                     child: Directionality(
                                                       textDirection: TextDirection.rtl,
                                                       child: TextField(
                                                         keyboardType: TextInputType.datetime,
                                                         controller: birthController,
                                                         onTap:(){
                                                           showDatePicker(
                                                             context: context,
                                                             initialDate: birthDay.toDate(),
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
                                                       onTap: ()async{
                                                         await updateUserData("dateOfBirth", birthDay);
                                                         Navigator.pop(context);
                                                       },
                                                     ),
                                                   ),
                                                 ],
                                               ));
                                         });
                                       },
                                     );
                                   },
                                   buttonVis: false,
                                   ),
                                 ],
                               ),
                               DepContainer(
                                 "بيانات الهوية",
                                 children: [
                                   SettingDataCard("رقم الهوية", _account.iqamaNumber,onPress: (){
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
                                                               "تحديث رقم الهوية",
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
                                                           controller: iqamaNumberController,
                                                           style: TextStyle(
                                                             color: color.primaryColor, fontSize: 20,),
                                                           decoration: InputDecoration(
                                                             labelText: "رقم الهوية",
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
                                                         onTap: ()async{
                                                           await updateUserData("iqamaNumber", iqamaNumberController.text.trim());
                                                           Navigator.pop(context);
                                                         },
                                                       ),
                                                     ),
                                                   ],
                                                 ));
                                           });
                                         });
                                   },),
                                   SettingDataCard("تاريخ انتهاء الهوية", "${_account.iqamaExpireDate.toDate().year}/${_account.iqamaExpireDate.toDate().month}/${_account.iqamaExpireDate.toDate().day}", onPress: (){
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
                                                             "تحديث تاريخ انتهاء الإقامة",
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
                                                     padding: EdgeInsets.only(bottom: 10, right: 30, left: 30),
                                                     child: Directionality(
                                                       textDirection: TextDirection.rtl,
                                                       child: TextField(
                                                         keyboardType: TextInputType.datetime,
                                                         controller: iqamaExpDateController,
                                                         onTap:(){
                                                           showDatePicker(
                                                             context: context,
                                                             initialDate: iqamaExpDate.toDate(),
                                                             firstDate: DateTime(DateTime.now().year),
                                                             lastDate: DateTime(DateTime.now().year+2, DateTime.now().month, DateTime.now().day),
                                                           ).then((pickedDate) {
                                                             iqamaExpDate=Timestamp.fromDate(pickedDate);
                                                             setState(() {
                                                               iqamaExpDateController.text="${iqamaExpDate.toDate().year}/${iqamaExpDate.toDate().month}/${iqamaExpDate.toDate().day}";
                                                             });
                                                           });
                                                         },
                                                         style: TextStyle(
                                                           fontSize: 20,
                                                         ),
                                                         decoration: InputDecoration(
                                                           labelText: "تاريخ انتهاء الإقامة",
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
                                                       onTap: ()async{
                                                         await updateUserData("iqamaExpireDate", iqamaExpDate);
                                                         Navigator.pop(context);
                                                       },
                                                     ),
                                                   ),
                                                 ],
                                               ));
                                         });
                                       },
                                     );
                                   },
                                     buttonVis: false,
                                   ),
                                   // SettingDataCard("رقم الجواز", "16",),
                                   // SettingDataCard("تاريخ انتهاء الجواز", "2",),
                                 ],
                               ),
                               DepContainer(
                                 "البيانات الأكاديمية",
                                 children: [
                                   SettingDataCard("الرقم الجامعي", _account.universityID,
                                     onPress: (){
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
                                                                 "تحديث الرقم الجامعي",
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
                                                             controller: universityIdController,
                                                             style: TextStyle(
                                                               color: color.primaryColor, fontSize: 20,),
                                                             decoration: InputDecoration(
                                                               labelText: "الرقم الجامعي",
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
                                                           onTap: ()async{
                                                             await updateUserData("universityID", universityIdController.text.trim());
                                                             Navigator.pop(context);
                                                           },
                                                         ),
                                                       ),
                                                     ],
                                                   ));
                                             });
                                           });
                                     },
                                   ),
                                   SettingDataCard("الدرجة العلمية", _account.degree,
                                     onPress: (){
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
                                                                 "تحديث الدرجة العلمية",
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
                                                         padding: EdgeInsets.only(bottom: 10, right: 30, left: 30),
                                                         child: Container(
                                                           width: double.infinity,
                                                           decoration: BoxDecoration(

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
                                                           onTap: ()async{
                                                             await updateUserData("degree", degree.trim());
                                                             Navigator.pop(context);
                                                           },
                                                         ),
                                                       ),
                                                     ],
                                                   ));
                                             });
                                           });
                                     },),
                                   SettingDataCard("الكلية", _account.college,onPress: (){
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
                                                               "تحديث الكلية",
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
                                                           controller: collegeController,
                                                           style: TextStyle(
                                                             color: color.primaryColor, fontSize: 20,),
                                                           decoration: InputDecoration(
                                                             labelText: "الكلية",
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
                                                         onTap: ()async{
                                                           await updateUserData("college", collegeController.text.trim());
                                                           Navigator.pop(context);
                                                         },
                                                       ),
                                                     ),
                                                   ],
                                                 ));
                                           });
                                         });
                                   },),
                                   SettingDataCard("التخصص", _account.department,
                                     onPress: (){
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
                                                                 "تحديث التخصص",
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
                                                             controller: departmentController,
                                                             style: TextStyle(
                                                               color: color.primaryColor, fontSize: 20,),
                                                             decoration: InputDecoration(
                                                               labelText: "التخصص",
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
                                                           onTap: ()async{
                                                             await updateUserData("department", departmentController.text.trim());
                                                             Navigator.pop(context);
                                                           },
                                                         ),
                                                       ),
                                                     ],
                                                   ));
                                             });
                                           });
                                     },
                                   ),
                                   SettingDataCard("المستوى",_account.level.toString(),onPress: (){
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
                                                               "تحديث المستوى",
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
                                                           keyboardType: TextInputType.numberWithOptions(decimal: false),
                                                           controller: levelController,
                                                           style: TextStyle(
                                                             color: color.primaryColor, fontSize: 20,),
                                                           decoration: InputDecoration(
                                                             labelText: "المستوى",
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
                                                         onTap: ()async{
                                                           await updateUserData("level", int.parse(levelController.text.trim()));
                                                           Navigator.pop(context);
                                                         },
                                                       ),
                                                     ),
                                                   ],
                                                 ));
                                           });
                                         });
                                   },),
                                   SettingDataCard("المعدل", _account.GPA.toString(),
                                     onPress: (){
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
                                                                 "تحديث المعدل",
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
                                                             controller: GPAController,
                                                             keyboardType: TextInputType.number,
                                                             style: TextStyle(
                                                               color: color.primaryColor, fontSize: 20,),
                                                             decoration: InputDecoration(
                                                               labelText: "المعدل",
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
                                                           onTap: ()async{
                                                             await updateUserData("GPA", double.parse(GPAController.text.trim()));
                                                             Navigator.pop(context);
                                                           },
                                                         ),
                                                       ),
                                                     ],
                                                   ));
                                             });
                                           });
                                     },
                                   ),
                                 ],
                               ),
                               DepContainer(
                                 "بيانات السكن",
                                 children: [
                                   SettingDataCard("نوع السكن", _account.housingType,
                                     onPress: (){
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
                                                                 "تحديث الرقم الجامعي",
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
                                                         padding: EdgeInsets.only(bottom: 10, left: 30, right: 30),
                                                         child: Container(
                                                           width: double.infinity,
                                                           decoration: BoxDecoration(

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
                                                           onTap: ()async{
                                                             await updateUserData("housingType", housingType);
                                                             Navigator.pop(context);
                                                           },
                                                         ),
                                                       ),
                                                     ],
                                                   ));
                                             });
                                           });
                                     },
                                   ),
                                   SettingDataCard("المبنى", _account.houseBuilding.toString(),visibility: houseDetails,
                                     onPress: (){
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
                                                                 "تحديث رقم المبنى",
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
                                                             keyboardType: TextInputType.numberWithOptions(decimal: false),
                                                             style: TextStyle(
                                                               color: color.primaryColor, fontSize: 20,),
                                                                onChanged: (value){
                                                                houseBuilding=int.parse(value);
                                                                },
                                                             decoration: InputDecoration(
                                                               labelText: "رقم المبنى",
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
                                                           onTap: ()async{
                                                             await updateUserData("houseBuilding", houseBuilding);
                                                             Navigator.pop(context);
                                                           },
                                                         ),
                                                       ),
                                                     ],
                                                   ));
                                             });
                                           });
                                     },
                                   ),
                                   SettingDataCard("الدور", _account.houseFloor.toString(),visibility: houseDetails,
                                     onPress: (){
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
                                                                 "تحديث رقم الدور",
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
                                                             keyboardType: TextInputType.numberWithOptions(decimal: false),
                                                             onChanged: (value){
                                                               houseFloor=int.parse(value);
                                                             },
                                                             style: TextStyle(
                                                               color: color.primaryColor, fontSize: 20,),
                                                             decoration: InputDecoration(
                                                               labelText: "رقم الدور",
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
                                                           onTap: ()async{
                                                             await updateUserData("houseFloor", houseFloor);
                                                             Navigator.pop(context);
                                                           },
                                                         ),
                                                       ),
                                                     ],
                                                   ));
                                             });
                                           });
                                     },
                                   ),
                                   SettingDataCard("الجناح", _account.houseSuite.toString(),visibility: houseDetails,                   onPress: (){
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
                                                               "تحديث رقم الجناح",
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
                                                           keyboardType: TextInputType.numberWithOptions(decimal: false),
                                                           onChanged: (value){
                                                             houseSuite=int.parse(value);
                                                           },
                                                           style: TextStyle(
                                                             color: color.primaryColor, fontSize: 20,),
                                                           decoration: InputDecoration(
                                                             labelText: "رقم الجناح",
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
                                                         onTap: ()async{
                                                           await updateUserData("houseSuite", houseSuite);
                                                           Navigator.pop(context);
                                                         },
                                                       ),
                                                     ),
                                                   ],
                                                 ));
                                           });
                                         });
                                   },),
                                   SettingDataCard("غرفة", _account.houseRoom.toString(),visibility: houseDetails,                   onPress: (){
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
                                                               "تحديث رقم الغرفة",
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
                                                           keyboardType: TextInputType.numberWithOptions(decimal: false),
                                                           onChanged: (value){
                                                             houseRoom=int.parse(value);
                                                           },
                                                           style: TextStyle(
                                                             color: color.primaryColor, fontSize: 20,),
                                                           decoration: InputDecoration(
                                                             labelText: "رقم الغرفة",
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
                                                         onTap: ()async{
                                                           await updateUserData("houseRoom", houseRoom);
                                                           Navigator.pop(context);
                                                         },
                                                       ),
                                                     ),
                                                   ],
                                                 ));
                                           });
                                         });
                                   },),
                                 ],
                               ),
                               DepContainer(
                                 "بيانات الأسرة",
                                 children: [
                                   SettingDataCard("هل الأسرة بالسعودية", _account.familyInSaudiArabia?"نعم":"لا",
                                     onPress: (){
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
                                                                 "تحديث رقم الغرفة",
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
                                                           onTap: ()async{
                                                             await updateUserData("familyInSaudiArabia", familyInSaudiArabia);
                                                             Navigator.pop(context);
                                                           },
                                                         ),
                                                       ),
                                                     ],
                                                   ));
                                             });
                                           });
                                     },
                                   ),
                                   SettingDataCard("عدد أفراد الأسرة", _account.numberOfFamily.toString(), visibility: _account.familyInSaudiArabia, onPress: (){
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
                                                               "تحديث عدد أفراد الأسرة",
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
                                                           keyboardType: TextInputType.numberWithOptions(decimal: false),
                                                           onChanged: (value){
                                                             numberOfFamilyMember=int.parse(value);
                                                           },
                                                           style: TextStyle(
                                                             color: color.primaryColor, fontSize: 20,),
                                                           decoration: InputDecoration(
                                                             labelText: "عدد أفراد الأسرة",
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
                                                         onTap: ()async{
                                                           await updateUserData("numberOfFamily", numberOfFamilyMember);
                                                           Navigator.pop(context);
                                                         },
                                                       ),
                                                     ),
                                                   ],
                                                 ));
                                           });
                                         });
                                   },),
                                 ],
                               ),
                               DepContainer(
                                 "بيانات التواصل",
                                 children: [
                                   SettingDataCard("رقم الجوال", _account.phoneNumber, onPress: (){
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
                                                               "تحديث رقم الجوال",
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
                                                           keyboardType: TextInputType.phone,
                                                           controller: phoneNumberController,
                                                           style: TextStyle(
                                                             color: color.primaryColor, fontSize: 20,),
                                                           decoration: InputDecoration(
                                                             labelText: "رقم الجوال",
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
                                                         onTap: ()async{
                                                           await updateUserData("phoneNumber", phoneNumberController.text.trim());
                                                           Navigator.pop(context);
                                                         },
                                                       ),
                                                     ),
                                                   ],
                                                 ));
                                           });
                                         });
                                   },),
                                   SettingDataCard("العنوان بالبلد الأم", _account.addressInCountry, onPress: (){
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
                                                               "تحديث العنوان بالبلد الأم",
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
                                                           keyboardType: TextInputType.numberWithOptions(decimal: false),
                                                           controller: addressInCountryController,
                                                           style: TextStyle(
                                                             color: color.primaryColor, fontSize: 20,),
                                                           decoration: InputDecoration(
                                                             labelText: "العنوان بالبلد الأم",
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
                                                         onTap: ()async{
                                                           await updateUserData("addressInCountry", addressInCountryController.text.trim());
                                                           Navigator.pop(context);
                                                         },
                                                       ),
                                                     ),
                                                   ],
                                                 ));
                                           });
                                         });
                                   },),
                                   SettingDataCard("رقم التواصل بالبلد الأم", _account.phoneInCountry,onPress: (){
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
                                                               "تحديث رقم التواصل بالبلد الأم",
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
                                                           keyboardType: TextInputType.phone,
                                                           controller: contactNumberInCountryController,
                                                           style: TextStyle(
                                                             color: color.primaryColor, fontSize: 20,),
                                                           decoration: InputDecoration(
                                                             labelText: "رقم التواصل بالبلد الأم",
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
                                                         onTap: ()async{
                                                           await updateUserData("phoneInCountry", contactNumberInCountryController.text.trim());
                                                           Navigator.pop(context);
                                                         },
                                                       ),
                                                     ),
                                                   ],
                                                 ));
                                           });
                                         });
                                   },),
                                 ],
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
  SettingDataCard(this.label, this.data, {this.onPress = null, this.visibility=true, this.buttonVis=true});

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