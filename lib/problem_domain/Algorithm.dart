import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ksu_scholarship/problem_domain/models/Account.dart';

/// Auth function

// upload user data
void uploadUser(Account account)async{
  await FirebaseFirestore.instance.collection("users").doc(account.uid).set(account.toMap());
}