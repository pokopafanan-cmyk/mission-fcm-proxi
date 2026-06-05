import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {

  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  static void _log(
      Level level,
      Object? message, {
        Object? error,
        StackTrace? stackTrace,
      }) {
    if (!kDebugMode) return;

    _logger.log(
      level,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void debug(Object? message) => _log(Level.debug, message);

  static void info(Object? message) => _log(Level.info, message);

  static void warning(Object? message) => _log(Level.warning, message);

  static void error(
      Object? message, {
        Object? error,
        StackTrace? stackTrace,
      }) =>
      _log(
        Level.error,
        message,
        error: error,
        stackTrace: stackTrace,
      );

  static void printer(Object? message) {
    if(kDebugMode) print(message);
  }

}




