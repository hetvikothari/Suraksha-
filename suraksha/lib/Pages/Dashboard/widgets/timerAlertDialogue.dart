import 'dart:async';
import 'package:flutter/material.dart';
import 'package:suraksha/Helpers/constants.dart';

class TimeAlertDialogue extends StatefulWidget {
  const TimeAlertDialogue({Key? key}) : super(key: key);

  @override
  State<TimeAlertDialogue> createState() => _TimeAlertDialogueState();
}

class _TimeAlertDialogueState extends State<TimeAlertDialogue> {
  int _counter = 0;
  late StreamController<int> _events;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _events = new StreamController<int>();
    _events.add(10);
    _startTimer();
  }

  void _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      (_counter > 0) ? _counter-- : _timer!.cancel();
      _events.add(_counter);
    });
  }

  void _stopTimer() {
    _timer!.cancel();
  }

  AlertDialog alertD(BuildContext ctx) {
    return AlertDialog(
        // title: Center(child:Text('Enter Code')),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        content: StreamBuilder<int>(
            stream: _events.stream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.data.toString() == "0") {
                Navigator.pop(context);
              }
              // print(snapshot.data.toString());
              return Container(
                height: 155,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'Tap Cancel within ${snapshot.data.toString()} seconds to cancel the alert '),
                    // Text('00:${snapshot.data.toString()}'),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                print("tappped");
                                _stopTimer();
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: primaryColor),
                                child: Center(
                                    child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //new column child
                  ],
                ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return alertD(context);
  }
}
