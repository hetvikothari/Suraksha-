import 'package:flutter/material.dart';
import 'package:suraksha/Helpers/constants.dart';
import 'package:suraksha/Models/EmergencyContact.dart';

class ContactDetailPage extends StatefulWidget {
  final EmergencyContact? ec;

  const ContactDetailPage({Key? key, required this.ec}) : super(key: key);

  @override
  _ContactDetailPageState createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: primaryColor,
                  child: Icon(Icons.edit),
                ),
                SizedBox(height: 20),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.red,
                  child: Icon(Icons.delete),
                )
              ],
            )),
        // FloatingActionButton(
        //   onPressed: () {},
        //   backgroundColor: primaryColor,
        //   child: const Text("Edit"),
        // ),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back), onPressed: () {}),
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
