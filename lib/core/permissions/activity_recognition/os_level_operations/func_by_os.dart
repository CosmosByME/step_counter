import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:step_counter/core/logger/logger.dart';

Future<bool> checkPermissionByOS() async {
  Logger.instance.d('checkPermissionByOS: platform=${Platform.operatingSystem}');
  if (Platform.isAndroid) {
    final granted = await Permission.activityRecognition.isGranted;
    Logger.instance.d('Android activityRecognition.isGranted=$granted');
    return granted;
  } else if (Platform.isIOS) {
    final granted = await Permission.sensors.isGranted;
    Logger.instance.d('iOS sensors.isGranted=$granted');
    return granted;
  } else {
    Logger.instance.w('Unsupported platform for activity recognition: ${Platform.operatingSystem}');
    return false; // Unsupported platform
  }
}

Future<PermissionStatus> requestPermissionByOS() async {
  Logger.instance.d('requestPermissionByOS: platform=${Platform.operatingSystem}');
  if (Platform.isAndroid) {
    final status = await Permission.activityRecognition.request();
    Logger.instance.i('Android request result: $status');
    return status;
  } else if (Platform.isIOS) {
    final status = await Permission.sensors.request();
    Logger.instance.i('iOS request result: $status');
    return status;
  } else {
    Logger.instance.w('Unsupported platform for requesting permission: ${Platform.operatingSystem}');
    return PermissionStatus.denied; // Unsupported platform
  }
}