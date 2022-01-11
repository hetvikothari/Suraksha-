import 'package:flutter/material.dart';
import 'package:suraksha/Pages/Dashboard/dashboard.dart';
import 'package:suraksha/Services/auth.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  AuthenticationController ac = new AuthenticationController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
                              fit: BoxFit.fill))),
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
                            child: Column(children: <Widget>[
                              Container(
                                  height: 60,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        suffixIcon: const Icon(Icons.email),
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter email';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      if (value != null) email = value;
                                    },
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        suffixIcon:
                                            const Icon(Icons.visibility_off),
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      if (value != null) password = value;
                                    },
                                  ))
                            ])),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () async {
                            if (await ac.login(email, password)) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Dashboard()));
                            }
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6)
                                  ])),
                              child: const Center(
                                  child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                        ),
                        const SizedBox(height: 50),
                        const Text("Forgot Password?",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1))),
                        const SizedBox(height: 20.0),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpPage()));
                            },
                            child: const Text('Don\'t have an account? SignUp',
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1)))),
                        const SizedBox(height: 20),
                        GestureDetector(
                            child: const Text("Dashboard",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1))),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Dashboard()));
                            })
                      ]))
                ]))));
  }
}
