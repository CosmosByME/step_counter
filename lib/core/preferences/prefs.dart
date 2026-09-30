import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_counter/core/errors/exceptions.dart';
import 'package:step_counter/core/logger/logger.dart';

class Prefs {

  Prefs();


  void saveData(Map<String, dynamic> data, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(data);
    await prefs.setString(key, encoded);
    Logger.instance.i('Saved data for key=$key: $data');
  }

  Future<Map<String, dynamic>> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data != null) {
      Logger.instance.i('Read data for key=$key: $data');
      return jsonDecode(data);
    } else {
      Logger.instance.w('No data found for key: $key');
      throw DataNotFoundException(message: "No data found for key: $key");
    }
  }
}