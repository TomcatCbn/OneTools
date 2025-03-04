import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:logger/logger.dart' as third;

class Logger {
  static final _logger = third.Logger(printer: third.SimplePrinter());

  /// 全局唯一备份，每次启动都会新建
  static IOSink? _backup;
  static IOSink? _logSink;

  static bool logConsole = true;

  static void init(String fileDir, {bool logToConsole = true}) {
    logConsole = logToConsole;
    var timestamp = formatDate(
        DateTime.now(), [yyyy, '-', mm, '-', dd, '-', HH, '-', nn, '-', ss]);
    File file = File('$fileDir/onetools-$timestamp.log');
    file.createSync(recursive: true);
    _backup = file.openWrite(mode: FileMode.append);
  }

  static void i({String msg = '', String tag = 'DEFAULT'}) {
    final t = '[INFO][$tag] $msg';
    if (logConsole) {
      _logger.i(t);
    }
    _backup?.write(t);
    _logSink?.write(t);
  }

  static void d({String msg = '', String tag = 'DEFAULT'}) {
    final t = '[DEBUG][$tag] $msg';
    if (logConsole) {
      _logger.d(t);
    }
    _backup?.write(t);
    _logSink?.write(t);
  }

  static void e({String msg = '', String tag = 'DEFAULT'}) {
    final t = '[ERROR][$tag] $msg';
    if (logConsole) {
      _logger.e(t);
    }
    _backup?.write(t);
    _logSink?.write(t);
  }

  // 创建一个新的日志文件，同时所有后续的操作也会记录到这份文件中
  static void logToNewFile({required String filePath}) {
    if (_logSink != null) {
      try {
        _logSink?.close();
      } catch (e) {}
    }
    File file = File(filePath);
    file.createSync(recursive: true);
    _logSink = file.openWrite(mode: FileMode.append);
  }

  static void closeFileWrite() {
    _logSink?.flush();
    try {
      _logSink?.close();
      _logSink = null;
    } catch (e) {}
  }
}
