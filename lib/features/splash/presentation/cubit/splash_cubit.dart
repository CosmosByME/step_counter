import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:step_counter/core/permissions/activity_recognition/check_permission.dart';
import 'package:step_counter/core/permissions/activity_recognition/request_permission.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void initialize() async {
    bool permissionIsGranted = await checkPermission();
    if (permissionIsGranted) {
      emit(SplashSuccess());
    } else {
      onSplashError();
    }
  }

  void onSplashError() async {
    bool requestSuccessful = await requestPermission();
    if (requestSuccessful) {
      emit(SplashSuccess());
    } else {
      emit(SplashError());
    }
  }
}
