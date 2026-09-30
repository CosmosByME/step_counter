import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:step_counter/core/errors/exceptions.dart';
import 'package:step_counter/core/preferences/prefs.dart';
import 'package:step_counter/core/logger/logger.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  final Prefs prefs = Prefs();

  UserDetailsCubit() : super(UserDetailsInitial());

  void initialize() async {
    try {
      final data = await prefs.getData('user_details');
      Logger.instance.i('Loaded user_details: $data');

      int? age = _toInt(data['age']);
      String gender = (data['gender'] as String?) ?? 'unknown';
      double? height = _toDouble(data['heightCm']);
      double? weight = _toDouble(data['weightKg']);

      if (height == null || weight == null) {
        Logger.instance.w('Missing numeric user fields: height=$height weight=$weight');
      }

      emit(
        UserDetailsFetched(
          age: age ?? 0,
          gender: gender,
          heightCm: height ?? 0.0,
          weightKg: weight ?? 0.0,
        ),
      );
    } on DataNotFoundException catch (e) {
      Logger.instance.w('No user_details found: ${e.message}');
      emit(UserDetailsError(e.message));
      showError(e.message);
    } catch (e) {
      Logger.instance.e('Failed to initialize UserDetailsCubit', e);
      showError('Something went wrong');
    }
  }

  int? _toInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is String) return int.tryParse(v);
    return null;
  }

  double? _toDouble(dynamic v) {
    if (v == null) return null;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is String) return double.tryParse(v);
    return null;
  }

  void saveUserDetails(Map<String, dynamic> data) {
    try {
      prefs.saveData(data, 'user_details');
      initialize();
    } catch (e) {
      showError('Something went wrong');
    }
  }

  void showError(String message) {
    emit(UserDetailsError(message));
  }
}
