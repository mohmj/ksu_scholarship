import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksu_scholarship/problem_domain/models/Account.dart';
import 'package:ksu_scholarship/problem_domain/models/food_supply_order.dart';
import 'package:ksu_scholarship/problem_domain/models/housing_order.dart';

/// Device
// Check the version of app
Future retrieveVersion()async{
  var a= await FirebaseFirestore.instance.collection('AppData').doc('versions').get();
  print(a['android']);
}

Future<Account> retrieveUserNew()async{
  var b=await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).get();
  Account a=Account.fromMap(b as Map<String, dynamic>);
  return  a;
}

Future<Account> getUserInformation(String uid)async{
  DocumentSnapshot _userInfo=await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return Account.fromMap(_userInfo.data());
}

/// Auth function

// upload user data
void uploadUser(Account account)async{
  await FirebaseFirestore.instance.collection("users").doc(account.uid).set(account.toMap());
}

/// User data
// Get user information
Future retrieveUserData()async{
  QuerySnapshot _query=await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: FirebaseAuth.instance.currentUser.uid).get();
  return _query.docs;
}

retrieveUserDataDoc()async{
  DocumentSnapshot _doc=await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).get();
  return _doc;
}

Stream<Account>retrieveUserDataStream(){
  return FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .snapshots()
      .map((DocumentSnapshot documentSnapshot) => Account.fromMap(
    documentSnapshot.data(),
  ));
}


/// orders
// get orders for user
Future retrieveOrders()async{
  QuerySnapshot _orders=await FirebaseFirestore.instance.collection("orders").where("uid",isEqualTo: FirebaseAuth.instance.currentUser.uid).orderBy("orderDate", descending: true).get();
  return _orders.docs;
}

Future retrieveOrdersAdmins() async{
  QuerySnapshot _orders=await FirebaseFirestore.instance.collection("orders").orderBy("orderDate", descending: true).get();
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

void uploadFoodSupplyOrder(FoodSupplyOrder fs)async {
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("orders");
  DocumentReference documentReference = await collectionReference.add(
      fs.toMap());
  fs.documentRef = documentReference.id;
  await documentReference.set(fs.toMap(), SetOptions(merge: true));
}

/// Setting methods

updateUserData(String label, dynamic data)async{
  await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).update(
      {label:data});
}
