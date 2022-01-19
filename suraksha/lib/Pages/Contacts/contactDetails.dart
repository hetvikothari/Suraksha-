import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suraksha/Helpers/constants.dart';
import 'package:suraksha/Models/EmergencyContact.dart';
import 'package:suraksha/Pages/Contacts/editContact.dart';
import 'package:suraksha/Pages/Contacts/mycontacts.dart';
import 'package:suraksha/Services/ContactService.dart';

class ContactDetailPage extends StatefulWidget {
  final EmergencyContact? ec;

  const ContactDetailPage({Key? key, required this.ec}) : super(key: key);

  @override
  _ContactDetailPageState createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  static String? email;

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('userEmail');
  }

  @override
  void initState() {
    super.initState();
    getEmail();
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new FloatingActionButton(
                  heroTag: "Edit",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditContactPage(
                                  ec: widget.ec,
                                )));
                  },
                  backgroundColor: primaryColor,
                  child: Icon(Icons.edit),
                ),
                SizedBox(height: 20),
                new FloatingActionButton(
                  heroTag: "Delete",
                  onPressed: () {
                    deleteContact(widget.ec, email!);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyContactsScreen()));
                  },
                  backgroundColor: Colors.red,
                  child: Icon(Icons.delete),
                )
              ],
            )),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(widget.ec!.name)),
        body: SafeArea(
          child: ListView(children: [
            ContactDetailCard(
              label: "Name",
              value: widget.ec!.name,
              icon: Icons.person,
            ),
            ContactDetailCard(
              label: "Phone Number",
              value: widget.ec!.phoneno,
              icon: Icons.phone_android,
            ),
            ContactDetailCard(
              label: "Email",
              value: widget.ec!.email,
              icon: Icons.email,
            ),
          ]),
        ));
  }
}

class ContactDetailCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const ContactDetailCard(
      {Key? key, required this.label, required this.value, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.grey[200], child: Icon(icon)),
            title: Text(label),
            subtitle: Text(value)));
  }
}
