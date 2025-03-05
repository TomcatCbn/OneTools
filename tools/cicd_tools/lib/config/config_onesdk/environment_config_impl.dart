import 'package:cicd_tools/domain/entities/stage_config.dart';

class EnvironmentImpl extends Environment {

  /// 修改成自己的androidHome
  @override
  String get androidHome => '';

  /// one sdk需要java11
  @override
  String get javaHome => '';

}
