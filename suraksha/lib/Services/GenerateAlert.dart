import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suraksha/Models/EmergencyContact.dart';
import 'package:suraksha/Services/UserService.dart';
import 'package:workmanager/workmanager.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';

Future<void> sendLocationPeriodically() async {
  List<String> contacts = [];
  final prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('userEmail');
  List<EmergencyContact> ecs = await getUserContacts(email!);
  for (EmergencyContact i in ecs) {
    contacts.add(i.phoneno);
  }
  Workmanager().registerPeriodicTask("3", 'simplePeriodicTask',
      tag: "3",
      inputData: {"contacts": contacts},
      frequency: Duration(minutes: 15));
}

Future<void> backgroundVideoRecording() async {
  final cameras = await availableCameras();
  final front = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front);
  CameraController _cameraController =
      CameraController(front, ResolutionPreset.max);
  await _cameraController.initialize();
  await _cameraController.prepareForVideoRecording();
  await _cameraController.startVideoRecording();
  await Future.delayed(const Duration(seconds: 10), () {});
  print("10 secs Done");
  final file = await _cameraController.stopVideoRecording();
  print("\n\n\n");
  print(file.path);
  await GallerySaver.saveVideo(file.path);
  File(file.path).deleteSync();
  print("recording stopped");
}

Future<void> generateAlert() async {
  await sendLocationPeriodically();
  await backgroundVideoRecording();
}
