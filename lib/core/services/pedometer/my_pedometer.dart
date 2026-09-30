import 'dart:io';

import 'package:pedometer_2/pedometer_2.dart';
import 'package:step_counter/core/logger/logger.dart';

class MyPedometer {
  final pedometer = Pedometer();

  Stream<int> todaySteps() {
    Logger.instance.d('MyPedometer: creating todaySteps stream for platform=${Platform.operatingSystem}');
    return Platform.isIOS ? _todayStepsStreamOnIOS() : _todayStepsStreamOnAndroid();
  }


  Stream<int> _todayStepsStreamOnIOS() {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    Logger.instance.d('iOS pedometer stream from $startOfDay');
    return Pedometer().stepCountStreamFrom(from: startOfDay);
  }

  Stream<int> _todayStepsStreamOnAndroid() async* {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);

    int stepsBeforeAppOpen = await Pedometer().getStepCount(from: startOfDay);
    Logger.instance.d('Android pedometer initial steps before app open: $stepsBeforeAppOpen');

    Stream<int> stepCountStream = Pedometer().stepCountStream();
    int? initialHardwareCount;

    await for (int hardwareSteps in stepCountStream) {
      initialHardwareCount ??= hardwareSteps;
      int stepsTakenSinceAppOpen = hardwareSteps - initialHardwareCount;
      final total = stepsBeforeAppOpen + stepsTakenSinceAppOpen;
      Logger.instance.d('Hardware steps=$hardwareSteps initialHardwareCount=$initialHardwareCount total=$total');
      yield total;
    }
  }
}