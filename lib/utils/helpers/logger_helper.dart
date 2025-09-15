
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class LoggerHelper {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );

  static void debug(String message) {
    if (!kReleaseMode) _logger.d(message);
  }

  static void info(String message) {
    if (!kReleaseMode) _logger.i(message);
  }

  static void warning(String message) {
    if (!kReleaseMode) _logger.w(message);
  }

  static void error(String message, [dynamic error]) {
    if (!kReleaseMode) {
      _logger.e(message, error: error,);
    }
  }



}
