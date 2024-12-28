import 'package:logger/logger.dart' as third;

class Logger {
  static final _logger = third.Logger(printer: third.SimplePrinter());

  static void i({String msg = '', String tag = ''}) {
    _logger.i('[INFO][$tag]$msg');
  }

  static void d({String msg = '', String tag = ''}) {
    _logger.d('[DEBUG][$tag]$msg');
  }

  static void e({String msg = '', String tag = ''}) {
    _logger.e('[ERROR][$tag]$msg');
  }
}
