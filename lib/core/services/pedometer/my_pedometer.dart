import 'dart:io';

import 'package:pedometer_2/pedometer_2.dart';

class MyPedometer {
  final pedometer = Pedometer();

  Stream<int> todaySteps() {
    return Platform.isIOS ? _todayStepsStreamOnIOS() : _todayStepsStreamOnAndroid();
  }


  Stream<int> _todayStepsStreamOnIOS() {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    return Pedometer().stepCountStreamFrom(from: startOfDay);
  }

  Stream<int> _todayStepsStreamOnAndroid() async* {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);

    int stepsBeforeAppOpen = await Pedometer().getStepCount(from: startOfDay);

    Stream<int> stepCountStream = Pedometer().stepCountStream();
    int? initialHardwareCount;

    await for (int hardwareSteps in stepCountStream) {
      initialHardwareCount ??= hardwareSteps;
      int stepsTakenSinceAppOpen = hardwareSteps - initialHardwareCount;
      yield stepsBeforeAppOpen + stepsTakenSinceAppOpen;
    }
  }
}