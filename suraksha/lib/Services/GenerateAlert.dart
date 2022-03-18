import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suraksha/Models/EmergencyContact.dart';
import 'package:suraksha/Services/UserService.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';

Future<void> generateAlert() async {
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
  VideoRecording obj = new VideoRecording();
  obj._startRecord();
  await Future.delayed(const Duration(seconds: 10), () {});
  print("10 secs Done");
  obj._stopRecord();
}
//video recording

class VideoRecording {
  bool _isLoading = true;
  CameraController? _cameraController;

  VideoRecording() {
    print("heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    _initCamera();
    print("heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy22222222222222222222");
  }

  void dispose() {
    this._cameraController!.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    this._cameraController = CameraController(front, ResolutionPreset.max);

    this._isLoading = false;
  }

  _stopRecord() async {
    final file = await this._cameraController!.stopVideoRecording();
    print("\n\n\n");
    print(file.path);
    await GallerySaver.saveVideo(file.path);
    File(file.path).deleteSync();
    print("recording stopped");
  }

  _startRecord() async {
    print("recording started");
    await this._cameraController!.initialize();
    await this._cameraController!.prepareForVideoRecording();
    await this._cameraController!.startVideoRecording();
  }
}
