import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ksu_scholarship/constant/order_types.dart';

class HousingOrder{
  String orderType=OrderType().housing;
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
  String status;

  HousingOrder(String documentRef, String uid, String id, String name, String nationality, Timestamp orderDate,String orderStatus,Timestamp answerDate,String studentNote, String note,String pdfLink, String status){
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
    this.status=status;
  }

  HousingOrder.fromMap(Map<String, dynamic> data){
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
    status=data['status'];
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
      "status":status,
    };
  }

}