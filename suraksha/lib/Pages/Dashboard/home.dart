import 'dart:math';

import 'package:flutter/material.dart';
import 'package:suraksha/Pages/Dashboard/widgets/appbar.dart';
import 'package:suraksha/Pages/Dashboard/widgets/carousel.dart';
import 'package:suraksha/Pages/Dashboard/widgets/emergency.dart';
import 'package:suraksha/Pages/Dashboard/widgets/livesafe.dart';
import 'package:suraksha/Pages/Dashboard/widgets/locationmonitoring.dart';
import 'package:suraksha/Pages/Dashboard/widgets/safehome.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int quoteIndex = 0;
  @override
  void initState() {
    super.initState();
    getRandomInt(false);
  }

  getRandomInt(fromClick) {
    Random rnd = Random();

    quoteIndex = rnd.nextInt(4);
    if (mounted && fromClick) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashAppbar(getRandomInt: getRandomInt, quoteIndex: quoteIndex),
        Expanded(
          child: SizedBox(
            height: 100,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SafeCarousel(),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Emergency",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                          TextButton(
                              onPressed: () {}, child: const Text("See More"))
                        ])),
                const Emergency(),
                const Padding(
                    padding: EdgeInsets.only(left: 16.0, bottom: 10, top: 10),
                    child: Text("Explore LiveSafe",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))),
                const LiveSafe(),
                const LocationMonitoring(),
                const SafeHome(),
                const SizedBox(height: 50)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
