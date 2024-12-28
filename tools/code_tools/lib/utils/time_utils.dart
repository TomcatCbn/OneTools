import 'package:platform_utils/platform_utils.dart' as t;

String formatDate(DateTime dateTime) {
  return t.formatDate(dateTime,
      [t.yyyy, '年', t.mm, '月', t.dd, '日', t.HH, ':', t.nn, ':', t.ss]);
}
