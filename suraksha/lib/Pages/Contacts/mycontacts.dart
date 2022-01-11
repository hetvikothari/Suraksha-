import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:suraksha/Helpers/constants.dart';

class MyContactsScreen extends StatefulWidget {
  const MyContactsScreen({Key? key}) : super(key: key);

  @override
  _MyContactsScreenState createState() => _MyContactsScreenState();
}

class _MyContactsScreenState extends State<MyContactsScreen> {
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
      body: Column(
        children: const [
          contactCard(number: '1234567890', title: "Alice"),
          SizedBox(height: 10),
          contactCard(number: '9123456780', title: "Bob")
        ],
      ),
    );
  }
}

class contactCard extends StatelessWidget {
  final String title;
  final String number;
  const contactCard({Key? key, required this.number, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        actionPane: const SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
            color: Colors.white,
            child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const AssetImage("assets/user.png")),
                title: Text(title),
                subtitle: Text(number))),
        secondaryActions: <Widget>[
          IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {}),
        ]);
  }
}
