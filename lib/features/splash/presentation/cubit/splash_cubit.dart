import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:step_counter/core/permissions/activity_recognition/check_permission.dart';
import 'package:step_counter/core/permissions/activity_recognition/request_permission.dart';
import 'package:step_counter/core/logger/logger.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void initialize() async {
    Logger.instance.d('SplashCubit: initializing');
    bool permissionIsGranted = await checkPermission();
    Logger.instance.i('Activity recognition permission granted: $permissionIsGranted');
    if (permissionIsGranted) {
      emit(SplashSuccess());
    } else {
      onSplashError();
    }
  }

  void onSplashError() async {
    Logger.instance.d('SplashCubit: requesting permission');
    bool requestSuccessful = await requestPermission();
    Logger.instance.i('Permission request result: $requestSuccessful');
    if (requestSuccessful) {
      emit(SplashSuccess());
    } else {
      emit(SplashError());
    }
  }
}
