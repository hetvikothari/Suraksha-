import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suraksha/Pages/Dashboard/dashboard.dart';
import 'package:suraksha/Pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shake/shake.dart';
import 'package:hardware_buttons/hardware_buttons.dart';
// import 'package:hardware_buttons/hardware_buttons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeService();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('userEmail');
  if (email == null || email == '') {
    prefs.setBool('isLoggedIn', false);
    prefs.setString('userEmail', '');
  }
  runApp(MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
void onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
}

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event!["action"] == "setAsForeground") {
      service.setForegroundMode(true);
      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });

  // bring to foreground
  service.setForegroundMode(true);
  Timer.periodic(Duration(seconds: 1), (timer) async {
    if (!(await service.isServiceRunning())) timer.cancel();
    service.setNotificationInfo(
      title: "My App Service",
      content: "Updated at ${DateTime.now()}",
    );

    service.sendData(
      {"current_date": DateTime.now().toIso8601String()},
    );
  });

  // ShakeDetector.autoStart(
  //     shakeThresholdGravity: 7,
  //     onPhoneShake: () async {
  //       print("Test");
  //     });
}

// Future<void> onStart() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final service = FlutterBackgroundService();

//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   service.onDataReceived.listen((event) async {
//     if (event!["action"] == "setAsForeground") {
//       service.setForegroundMode(true);
//       return;
//     }
//     if (event["action"] == "setAsBackground") {
//       service.setForegroundMode(false);
//     }
//     if (event["action"] == "stopService") {
//       service.stopBackgroundService();
//     }
//   });
//   Location _location;

//   await BackgroundLocation.setAndroidNotification(
//     title: "Location tracking is running in the background!",
//     message: "You can turn it off from settings menu inside the app",
//     icon: '@mipmap/ic_logo',
//   );
//   BackgroundLocation.startLocationService(
//     distanceFilter: 20,
//   );

//   BackgroundLocation.getLocationUpdates((location) {
//     _location = location;
//     prefs.setStringList("location",
//         [location.latitude.toString(), location.longitude.toString()]);
//   });
//   String screenShake = "Be strong, We are with you!";
//   ShakeDetector.autoStart(
//       shakeThresholdGravity: 7,
//       onPhoneShake: () async {
//         print("Test");
//       });
//   print("Nothing");
//   // bring to foreground
//   service.setForegroundMode(true);
//   Timer.periodic(Duration(seconds: 1), (timer) async {
//     if (!(await service.isServiceRunning())) timer.cancel();

//     service.setNotificationInfo(
//       title: "Safe Shake activated!",
//       content: screenShake,
//     );

//     service.sendData(
//       {"current_date": DateTime.now().toIso8601String()},
//     );
//   });
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? email;

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('userEmail');
    });
  }

  @override
  void initState() {
    super.initState();
    getEmail();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      print("SHAKE DETECTOR");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Suraksha - Women Safety App',
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          primarySwatch: Colors.blue,
        ),
        home: email != null && email != '' ? Dashboard() : Splash());
  }
}
