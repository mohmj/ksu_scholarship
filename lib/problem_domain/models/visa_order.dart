import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ksu_scholarship/constant/order_types.dart';

class Visa{
  String orderType=OrderType().visa;
  String documentRef;
  String uid;
  String id;
  String name;
  String nationality;
  Timestamp orderDate;
  String orderStatus;
  Timestamp answerDate;
  String studentNote;
  String note;
  String pdfLink;
  //
  String iqamaNumber;
  Timestamp iqamaExpireDate;
  String degree;
  String college;
  String department;
  String level;
  String addressInCountry;
  String phoneInCountry;
  String whereTo;
  String travellingPeriod;


  Visa(String documentRef, String uid, String id, String name, String nationality, Timestamp orderDate,String orderStatus,Timestamp answerDate,String studentNote, String note,String pdfLink,
      String iqamaNumber, Timestamp iqamaExpireDate,String degree,String college, String department, String level, String addressInCountry,String whereTo,String travellingPeriod
      ){
    this.documentRef=documentRef;
    this.uid=uid;
    this.id=id;
    this.name=name;
    this.nationality=nationality;
    this.orderDate=orderDate;
    this.orderStatus=orderStatus;
    this.answerDate=answerDate;
    this.studentNote=studentNote;
    this.note=note;
    this.pdfLink=pdfLink;
    this.iqamaNumber=iqamaNumber;
    this.iqamaExpireDate=iqamaExpireDate;
    this.degree=degree;
    this.college=college;
    this.department=department;
    this.level=level;
    this.addressInCountry=addressInCountry;
    this.phoneInCountry=phoneInCountry;
    this.whereTo=whereTo;
    this.travellingPeriod=travellingPeriod;
  }

  Visa.fromMap(Map<String, dynamic> data){
    orderType=data['orderType'];
    documentRef=data['documentRef'];
    uid=data['uid'];
    id=data['id'];
    name=data['name'];
    nationality=data['nationality'];
    orderDate=data['orderData'];
    orderStatus=data['orderStatus'];
    answerDate=data['answerDate'];
    studentNote=data['studentNote'];
    note=data['note'];
    pdfLink=data['pdfLink'];
    iqamaNumber=data['iqamaNumber'];
    iqamaExpireDate=data['iqamaExpireDate'];
    degree=data['degree'];
    college=data['college'];
    department=data['department'];
    level=data['level'];
    addressInCountry=data['addressInCountry'];
    phoneInCountry=data['phoneInCountry'];
    whereTo=data['whereTo'];
    travellingPeriod=data['travellingPeriod'];
  }

  Map<String, dynamic> toMap(){
    return{
      "orderType":orderType,
      "documentRef":documentRef,
      "uid":uid,
      "id":id,
      "name":name,
      "nationality":nationality,
      "orderDate":orderDate,
      "orderStatus":orderStatus,
      "answerDate":answerDate,
      "studentNote":studentNote,
      "note":note,
      "pdfLink":pdfLink,
      "iqamaNumber":iqamaNumber,
      "iqamaExpireDate":iqamaExpireDate,
      "degree":degree,
      "college":college,
      "department":department,
      "level":level,
      "addressInCountry":addressInCountry,
      "phoneInCountry":phoneInCountry,
      "whereTo":whereTo,
      "travellingPeriod":travellingPeriod,
    };
  }

}