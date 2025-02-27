import 'package:cicd_tools/domain/entities/module.dart';

abstract class ModuleRepo {
  /// 根据模块名字获取module
  ModuleEntity? getBy(String moduleName);

  /// 返回所有配置的Module
  List<ModuleEntity> loadAll();
}