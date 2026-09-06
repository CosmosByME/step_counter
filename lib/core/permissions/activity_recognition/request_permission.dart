import 'package:permission_handler/permission_handler.dart';
import 'package:step_counter/core/permissions/activity_recognition/os_level_operations/func_by_os.dart';

/// Requests the activity recognition permission on the device.
/// Returns the resulting permission status.
Future<bool> requestPermission() async {
  PermissionStatus status = await requestPermissionByOS();
  return status.isGranted;
}