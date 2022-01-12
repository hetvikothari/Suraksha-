import 'dart:async';
// import 'package:suraksha/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suraksha/Models/EmergencyContact.dart';
import 'package:suraksha/Models/User.dart';
// import 'dart:convert';

Future<User?> getUserData(String email) async {
  try {
    print("email.....");
    print(email);
    CollectionReference userRef =
        FirebaseFirestore.instance.collection('email');

    userRef.doc(email).get().then((value) {
      dynamic docData = value.data();
      User? user;
      if (value.exists) {
        dynamic docData = value.data();
        user = User.fromMap(docData);
      }
      return user;
    });
    // print(doc);
    // if (doc.exists) {
    //   dynamic docData = doc.data();
    //   print(docData);
    //   User user = User.fromMap(docData);
    //   print(user);
    //   return user;
    // }
    return null;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<List<EmergencyContact>> getUserContacts(String email) async {
  User? user = await getUserData(email);
  return user == null ? [] : user.contacts;
}
