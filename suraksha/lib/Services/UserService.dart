import 'dart:async';
// import 'package:suraksha/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';

class UserService {
  Future<DocumentSnapshot> getUser(String email) async {
    try {
      CollectionReference userRef =
          FirebaseFirestore.instance.collection('user');

      DocumentSnapshot doc = await userRef.doc(email).get();
      return doc;
    } catch (e) {
      throw e;
    }
  }
}
