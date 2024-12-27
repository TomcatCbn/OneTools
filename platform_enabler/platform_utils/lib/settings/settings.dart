import 'dart:io';

Settings settings = DefaultSettings();

abstract class Settings {
  /// 工作空间
  String get workSpace;
}

class DefaultSettings extends Settings {
  @override
  final String workSpace;

  DefaultSettings()
      : workSpace =
            '''${Platform.environment['HOME'] ?? 'Unimplemented'}/onetools''';
}
