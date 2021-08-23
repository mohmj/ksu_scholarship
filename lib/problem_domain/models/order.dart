import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  String orderType;
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


  Order(String documentRef, String uid, String id, String name, String nationality, Timestamp orderDate,String orderStatus,Timestamp answerDate,String studentNote, String note,String pdfLink){
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
  }

  Order.fromMap(Map<String, dynamic> data){
    orderType=data['orderType'];
    documentRef=data['documentRef'];
    uid=data['uid'];
    id=data['id'];
    name=data['name'];
    nationality=data['nationality'];
    orderDate=data['orderDate'];
    orderStatus=data['orderStatus'];
    answerDate=data['answerDate'];
    studentNote=data['studentNote'];
    note=data['note'];
    pdfLink=data['pdfLink'];
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
    };
  }
}