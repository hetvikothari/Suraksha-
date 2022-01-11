import 'dart:async';
import 'package:suraksha/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthenticationController {
  String hashPassword(String pass) {
    var bytes = utf8.encode(pass); // data being hashed
    var encryptedS = sha256.convert(bytes);
    print(encryptedS.toString());
    return encryptedS.toString();
  }

  Future<bool> checkIfUserExists(String email) async {
    try {
      CollectionReference userRef =
          FirebaseFirestore.instance.collection('user');

      var doc = await userRef.doc(email).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> signup(User user) async {
    // check if the user exists
    if (await checkIfUserExists(user.email)) {
      return false;
    }
    // hash the password
    user.password = hashPassword(user.password);

    // add user to database
    final CollectionReference userRef =
        FirebaseFirestore.instance.collection('user');
    await userRef.doc(user.email).set(user.toJson());

    return true;
  }

  Future<Map> login(String email, String password) async {
    Map result = {'flag': false, 'message': ''};
    try {
      CollectionReference userRef =
          FirebaseFirestore.instance.collection('user');

      DocumentSnapshot doc = await userRef.doc(email).get();
      if (doc.exists) {
        dynamic docData = doc.data();
        if (docData["password"] == hashPassword(password)) {
          result["flag"] = true;
        } else {
          result["message"] = 'Please enter correct password.';
        }
      } else {
        result["message"] = 'You don\'t have an account. Please Sign Up!';
      }
    } catch (e) {
      result["message"] = 'Please try again later!';
    }
    return result;
  }
}
