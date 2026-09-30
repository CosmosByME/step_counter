import 'package:flutter/foundation.dart';

class Logger {
  Logger._internal();
  static final Logger instance = Logger._internal();

  /// Enable/disable logging (useful to turn off logs for release builds)
  bool enabled = true;

  void d(String message) => _log('DEBUG', message);
  void i(String message) => _log('INFO', message);
  void w(String message) => _log('WARN', message);
  void e(String message, [dynamic error]) => _log('ERROR', '$message${error != null ? ' - $error' : ''}');

  void _log(String level, String message) {
    if (!enabled) return;
    final now = DateTime.now().toIso8601String();
    // Simple print-based logger so it can be removed easily before release
    debugPrint('[$now] [$level] $message');
  }
}
