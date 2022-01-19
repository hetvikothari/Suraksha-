import 'package:flutter/material.dart';
import 'package:suraksha/Helpers/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suraksha/Models/EmergencyContact.dart';
import 'package:suraksha/Models/User.dart';
import 'package:suraksha/Pages/Contacts/contactDetails.dart';
import 'package:suraksha/Services/UserService.dart';

class MyContactsScreen extends StatefulWidget {
  const MyContactsScreen({Key? key}) : super(key: key);

  @override
  _MyContactsScreenState createState() => _MyContactsScreenState();
}

class _MyContactsScreenState extends State<MyContactsScreen> {
  String? email;
  List<EmergencyContact>? ecList;
  int ecLen = 0;

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('userEmail');
    User? user = await getUserData(email!);
    ecList = user!.contacts;
    ecLen = ecList!.length;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("SOS Contacts",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.black)),
          backgroundColor: primaryColor,
          leading: IconButton(
              icon: Image.asset("assets/phone_red.png"), onPressed: () {})),
      body: ecList != null
          ? ListView.builder(
              itemCount: ecLen,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ContactDetailPage(ec: ecList![index])));
                    },
                    child: ContactCard(ec: ecList![index]));
              })
          : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator()),
                  Text('Awaiting result...'),
                ])),
    );
  }
}

class ContactCard extends StatelessWidget {
  final EmergencyContact ec;
  const ContactCard({Key? key, required this.ec}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage: const AssetImage("assets/user.png")),
            title: Text(ec.name),
            subtitle: Text(ec.phoneno)));
  }
}
