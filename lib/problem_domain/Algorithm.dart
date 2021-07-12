import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksu_scholarship/problem_domain/models/Account.dart';
import 'package:ksu_scholarship/problem_domain/models/housing_order.dart';

/// Auth function

// upload user data
void uploadUser(Account account)async{
  await FirebaseFirestore.instance.collection("users").doc(account.uid).set(account.toMap());
}

/// User data
// Get user information
Future retrieveUserData()async{
  QuerySnapshot _orders=await FirebaseFirestore.instance.collection("users").where("uid",isEqualTo: FirebaseAuth.instance.currentUser.uid).get();
  return _orders.docs;
}


/// orders
// get orders
Future retrieveOrders()async{
  QuerySnapshot _orders=await FirebaseFirestore.instance.collection("orders").where("uid",isEqualTo: FirebaseAuth.instance.currentUser.uid).orderBy("orderDate", descending: true).get();
  return _orders.docs;
}

void uploadHousingOrder(HousingOrder ho)async {
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("orders");
  DocumentReference documentReference = await collectionReference.add(
      ho.toMap());
  ho.documentRef = documentReference.id;
  await documentReference.set(ho.toMap(), SetOptions(merge: true));
}