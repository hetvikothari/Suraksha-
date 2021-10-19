import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suraksha/Contacts/mycontacts.dart';
import 'package:suraksha/constants.dart';

class PhoneBook extends StatefulWidget {
  const PhoneBook({Key? key}) : super(key: key);

  @override
  _PhoneBookState createState() => _PhoneBookState();
}

class _PhoneBookState extends State<PhoneBook> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primaryColor,
          child: const Text("Save"),
        ),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back), onPressed: () {}),
            title: TextField(
                textInputAction: TextInputAction.search,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    prefixIcon: Icon(Icons.search,
                        color: Colors.white70, size: height * 0.03),
                    hintText: 'Search Name',
                    hintStyle: const TextStyle(color: Colors.white70)),
                onChanged: (string) {})),
        body: Column(children: const [
          contactCard(number: '1234567890', title: "Alice"),
          contactCard(number: '9123456780', title: "Bob")
        ]));
  }
}
