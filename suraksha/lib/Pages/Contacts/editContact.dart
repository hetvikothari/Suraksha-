import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suraksha/Helpers/constants.dart';
import 'package:suraksha/Helpers/validation.dart';
import 'package:suraksha/Models/EmergencyContact.dart';
import 'package:suraksha/Pages/Contacts/mycontacts.dart';
import 'package:suraksha/Services/ContactService.dart';

class EditContactPage extends StatefulWidget {
  EmergencyContact? ec;
  EditContactPage({Key? key, required this.ec}) : super(key: key);

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '', name = '', phone = '';
  Map fieldKeys = {
    'name': GlobalKey<FormFieldState>(),
    'email': GlobalKey<FormFieldState>(),
    'phone': GlobalKey<FormFieldState>()
  };

  static String? useremail;

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    useremail = prefs.getString('userEmail');
  }

  @override
  void initState() {
    super.initState();
    getEmail();
    print(useremail);
    email = widget.ec!.email;
    name = widget.ec!.name;
    phone = widget.ec!.phoneno;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("Edit Emergency Contact",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          backgroundColor: primaryColor,
        ),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        child: TextFormField(
                            initialValue: name,
                            key: fieldKeys['name'],
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Emergency Contact Name",
                                prefixIcon: const Icon(Icons.person),
                                hintStyle: TextStyle(color: Colors.grey[400])),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Emergency Contact name';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (fieldKeys["name"].currentState!.validate()) {
                                name = value;
                              }
                            }),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        child: TextFormField(
                          initialValue: email,
                          key: fieldKeys['email'],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Emergency Contact Email",
                              prefixIcon: const Icon(Icons.email),
                              hintStyle: TextStyle(color: Colors.grey[400])),
                          validator: isValidEmail,
                          onChanged: (value) {
                            if (fieldKeys['email'].currentState!.validate()) {
                              email = value;
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        child: TextFormField(
                          initialValue: phone,
                          key: fieldKeys['phone'],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Emergency Contact Number",
                              prefixIcon: const Icon(Icons.phone_android),
                              hintStyle: TextStyle(color: Colors.grey[400])),
                          validator: isValidPhone,
                          onChanged: (value) {
                            if (fieldKeys['phone'].currentState!.validate()) {
                              phone = value;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Map val = await updateContact(
                                new EmergencyContact(
                                    email: email, name: name, phoneno: phone),
                                widget.ec!,
                                useremail!);
                            if (val["flag"]) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyContactsScreen()));
                            } else {
                              Fluttertoast.showToast(
                                msg: val["message"],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                              );
                            }
                          }
                        },
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: const Center(
                                child: Text("UPDATE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)))),
                      ),
                    ])))));
  }
}
