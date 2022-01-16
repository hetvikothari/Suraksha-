import 'dart:async';
// import 'package:suraksha/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suraksha/Models/EmergencyContact.dart';
import 'package:suraksha/Models/User.dart';
// import 'dart:convert';

Future<User?> getUserData(String email) async {
  try {
    CollectionReference userRef = FirebaseFirestore.instance.collection('user');
    User? user;
    DocumentSnapshot doc = await userRef.doc(email).get();
    if (doc.exists) {
      dynamic docData = doc.data();
      user = User.fromMap(docData);
    }
    return user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<List<EmergencyContact>> getUserContacts(String email) async {
  User? user = await getUserData(email);
  return user == null ? [] : user.contacts;
}
