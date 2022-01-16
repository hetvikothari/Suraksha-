import 'package:flutter/material.dart';
import 'login.dart';
import 'package:suraksha/Helpers/validation.dart';
import 'package:suraksha/Services/auth.dart';
import 'package:suraksha/Models/EmergencyContact.dart';
import 'package:suraksha/Models/User.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String name, email, phone, emergencyName, emergencyEmail, emergencyPhone;
  static bool passflag = true, conpassflag = true;
  AuthenticationController ac = new AuthenticationController();
  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map fieldKeys = {
    'name': GlobalKey<FormFieldState>(),
    'email': GlobalKey<FormFieldState>(),
    'phone': GlobalKey<FormFieldState>(),
    'emergencyName': GlobalKey<FormFieldState>(),
    'emergencyEmail': GlobalKey<FormFieldState>(),
    'emergencyPhone': GlobalKey<FormFieldState>(),
    'password': GlobalKey<FormFieldState>(),
    'confirmpassword': GlobalKey<FormFieldState>()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/signup.png'),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                    key: fieldKeys['name'],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Name",
                                        suffixIcon: const Icon(Icons.person),
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (fieldKeys["name"]
                                          .currentState!
                                          .validate()) {
                                        name = value;
                                      }
                                    }),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  key: fieldKeys['email'],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      suffixIcon: const Icon(Icons.email),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  validator: isValidEmail,
                                  onChanged: (value) {
                                    if (fieldKeys['email']
                                        .currentState!
                                        .validate()) {
                                      email = value;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  key: fieldKeys["password"],
                                  controller: password,
                                  obscureText: passflag,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              passflag = !passflag;
                                            });
                                          },
                                          child: passflag
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility)),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  validator: isValidPassword,
                                  onChanged: (value) {
                                    fieldKeys['password']
                                        .currentState!
                                        .validate();
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  key: fieldKeys["confirmpassword"],
                                  controller: confirmpassword,
                                  obscureText: conpassflag,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              conpassflag = !conpassflag;
                                            });
                                          },
                                          child: conpassflag
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility)),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    if (!passwordsMatch(password.text, value)) {
                                      return 'Password does not match';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    fieldKeys['confirmpassword']
                                        .currentState!
                                        .validate();
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  key: fieldKeys['phone'],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Phone number",
                                      suffixIcon:
                                          const Icon(Icons.phone_android),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  validator: isValidPhone,
                                  onChanged: (value) {
                                    if (fieldKeys['phone']
                                        .currentState!
                                        .validate()) {
                                      phone = value;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: TextFormField(
                                    key: fieldKeys["emergencyName"],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Emergency Contact Name",
                                        suffixIcon: const Icon(Icons.person),
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == "") {
                                        return 'Please enter name';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (fieldKeys['emergencyName']
                                          .currentState!
                                          .validate()) {
                                        emergencyName = value;
                                      }
                                    },
                                  )),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  key: fieldKeys["emergencyPhone"],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Emergency Contact Phone",
                                      suffixIcon:
                                          const Icon(Icons.phone_android),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  validator: isValidPhone,
                                  onChanged: (value) {
                                    if (fieldKeys['emergencyPhone']
                                        .currentState!
                                        .validate()) {
                                      emergencyPhone = value;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  key: fieldKeys["emergencyEmail"],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Emergency Contact Email",
                                      suffixIcon:
                                          const Icon(Icons.phone_android),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  validator: isValidEmail,
                                  onChanged: (value) {
                                    if (fieldKeys["emergencyEmail"]
                                        .currentState!
                                        .validate()) {
                                      emergencyEmail = value;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Map val = await ac.signup(User(
                                  name: name,
                                  email: email,
                                  password: password.text,
                                  phone: phone,
                                  contacts: [
                                    EmergencyContact(
                                        email: emergencyEmail,
                                        name: emergencyName,
                                        phoneno: emergencyPhone)
                                  ]));
                              if (val["flag"]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
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
                                  child: Text("SIGNUP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))),
                        ),
                        const SizedBox(height: 20.0),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: const Text('Already have an account? Login',
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1))))
                      ]))
                ]))));
  }
}
