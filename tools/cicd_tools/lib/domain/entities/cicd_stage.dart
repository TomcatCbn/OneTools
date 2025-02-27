// CICD Stage抽象
import 'package:platform_utils/platform_command.dart';

import 'cicd_errors.dart';
import 'module.dart';

abstract class CICDStage {
  final String nameId;

  CICDStage({required this.nameId});

  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    return Either.left(CICDUnImplementError());
  }
}

/// 确认模块依赖关系
class DependencyCheckStage extends CICDStage {
  DependencyCheckStage() : super(nameId: 'DependencyCheckStage');
}

/// 代码拉取，并切换分支
/// 可以是单个模块，也可以是多个模块
class CodeFetchStage extends CICDStage {
  final List<ModuleEntity> modules;

  CodeFetchStage({required this.modules}) : super(nameId: 'CodeFetchStage');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    return Either.left(CICDUnImplementError());
  }
}

// TODO
class UnitStage extends CICDStage {
  UnitStage({required super.nameId});
}

// TODO
class SonarStage extends CICDStage {
  SonarStage({required super.nameId});
}
