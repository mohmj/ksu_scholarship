import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ksu_scholarship/problem_domain/models/Account.dart';
import 'package:ksu_scholarship/problem_domain/models/housing_order.dart';

/// Auth function

// upload user data
void uploadUser(Account account)async{
  await FirebaseFirestore.instance.collection("users").doc(account.uid).set(account.toMap());
}


/// Housing
void uploadHousingOrder(HousingOrder ho)async{
  CollectionReference collectionReference=FirebaseFirestore.instance.collection("orders");
  DocumentReference documentReference=await collectionReference.add(ho.toMap());
  ho.documentRef=documentReference.id;
  await documentReference.set(ho.toMap(), SetOptions(merge: true));
}