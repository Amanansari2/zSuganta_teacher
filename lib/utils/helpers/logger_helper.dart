
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class LoggerHelper {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(

      lineLength: 500,
      colors: true,
      printEmojis: true,
    ),
    level: Level.debug,
  );

  // static void debug(String message) {
  //   if (!kReleaseMode) _logger.d(message);
  // }
  //
  // static void info(String message) {
  //   if (!kReleaseMode) _logger.i(message);
  // }
  //
  // static void warning(String message) {
  //   if (!kReleaseMode) _logger.w(message);
  // }

  // static void error(String message, [dynamic error]) {
  //   if (!kReleaseMode) {
  //     _logger.e(message, error: error,);
  //   }
  // }

  static void debug(String message) {
    if (!kReleaseMode) _printChunked(message, (msg) => _logger.d(msg));
  }

  static void info(String message) {
    if (!kReleaseMode) _printChunked(message, (msg) => _logger.i(msg));
  }

  static void warning(String message) {
    if (!kReleaseMode) _printChunked(message, (msg) => _logger.w(msg));
  }

  static void error(String message, [dynamic error]) {
    if (!kReleaseMode) _printChunked(message, (msg) => _logger.e(msg, error: error));
  }

  static void _printChunked(String message, Function(String) logFn) {
    const int chunkSize = 800;
    if (message.length <= chunkSize) {
      logFn(message);
      return;
    }

    for (var i = 0; i < message.length; i += chunkSize) {
      logFn(message.substring(
        i,
        i + chunkSize > message.length ? message.length : i + chunkSize,
      ));
    }
  }

}
