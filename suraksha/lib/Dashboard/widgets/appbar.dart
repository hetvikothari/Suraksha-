import 'package:flutter/material.dart';
import 'package:suraksha/constants.dart';

class DashAppbar extends StatelessWidget {
  final Function getRandomInt;
  final int quoteIndex;
  const DashAppbar(
      {Key? key, required this.getRandomInt, required this.quoteIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(sweetSayings[quoteIndex][0],
            style: TextStyle(color: Colors.grey[600])),
        subtitle: GestureDetector(
          onTap: () {
            getRandomInt(true);
          },
          child: Text(sweetSayings[quoteIndex][1],
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
        trailing: Card(
            elevation: 4,
            shape: const CircleBorder(),
            child: InkWell(
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset("assets/settings.png", height: 24)),
            )));
  }
}
