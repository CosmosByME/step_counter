import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPermissionByOS() async {
  if (Platform.isAndroid) {
    return await Permission.activityRecognition.isGranted;
  } else if (Platform.isIOS) {
    return await Permission.sensors.isGranted;
  } else {
    return false; // Unsupported platform
  }
}

Future<PermissionStatus> requestPermissionByOS() async {
  if (Platform.isAndroid) {
    return await Permission.activityRecognition.request();
  } else if (Platform.isIOS) {
    return await Permission.sensors.request();
  } else {
    return PermissionStatus.denied; // Unsupported platform
  }
}