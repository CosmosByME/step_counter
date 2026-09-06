import 'package:step_counter/core/permissions/activity_recognition/os_level_operations/func_by_os.dart';

/// Checks if the activity recognition permission is granted on the device.
///
/// Works for Android and iOS and returns ```false``` for unsupported platforms.
Future<bool> checkPermission() async {
  bool isPermissionGranted = await checkPermissionByOS();
  return isPermissionGranted;
}
