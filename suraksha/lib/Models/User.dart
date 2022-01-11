import 'package:suraksha/Models/EmergencyContact.dart';
import 'dart:convert';

class User {
  String email;
  String password;
  String name;
  String phone;
  List<EmergencyContact> contacts;

  User(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone,
      required this.contacts});

  factory User.fromMap(Map<String, String> json) {
    List<EmergencyContact> contacts = [];
    if (json['contacts'] != null) {
      contacts = (json["contacts"] as List<Map<String, String>>)
          .map((i) => EmergencyContact.fromMap(i))
          .toList();
    }
    User newUser = User(
      email: json['email'].toString(),
      password: json['password'].toString(),
      name: json['name'].toString(),
      phone: json['phone'].toString(),
      contacts: contacts,
    );
    return newUser;
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'contacts':
            jsonDecode(jsonEncode(contacts.map((e) => e.toJson()).toList()))
      };
}
