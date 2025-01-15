import 'dart:io';
import 'package:hive/hive.dart';

Settings settings = DefaultSettings();

abstract class Settings {
  /// OneTool的工作空间
  String get workSpace;
}

class DefaultSettings extends Settings {
  @override
  final String workSpace;

  DefaultSettings()
      : workSpace =
            '''${Platform.environment['HOME'] ?? 'Unimplemented'}/CEA_OneTools''';
}

class PlatformSettingBox {
  static final PlatformSettingBox _settingBox = PlatformSettingBox._();

  PlatformSettingBox._();

  factory PlatformSettingBox() => _settingBox;

  late Box _box;

  Future<void> init() async {
    Hive.init(settings.workSpace);
    _box = await Hive.openBox('global_settings');
  }

  String getString(String key) {
    return _box.get(key, defaultValue: '');
  }

  bool getBool(String key) {
    return _box.get(key, defaultValue: false) as bool;
  }

  void putString(String key, String value) {
    _box.put(key, value);
  }

  void putBool(String key, bool value) {
    _box.put(key, value);
  }
}
