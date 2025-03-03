// CICD Stage抽象
import 'dart:io';

import 'package:cicd_tools/domain/entities/stage_config.dart';
import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_utils.dart';

import 'cicd_errors.dart';
import 'module.dart';

abstract class CICDStage {
  final String nameId;

  int progress = 0;

  CICDStage({required this.nameId});

  Future<Either<CICDError, Map<String, Object>>> run(Map<String, Object> args);
}

/// 确认模块依赖关系
class DependencyCheckStage extends CICDStage {
  DependencyCheckStage() : super(nameId: 'DependencyCheckStage');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(Map<String, Object> args) {
    // TODO: implement run
    throw UnimplementedError();
  }
}

/// 代码拉取，并切换分支
/// 可以是单个模块，也可以是多个模块
class CodeFetchStage extends CICDStage {
  final List<ModuleEntity> modules;

  CodeFetchStage({required this.modules}) : super(nameId: 'CodeFetchStage');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    var map = <String, ModuleEntity>{};
    var list = modules.map((e) {
      return MapEntry<String, ModuleEntity>(e.moduleName, e);
    }).toList(growable: false);
    map.addEntries(list);
    args[CONFIG_MODULES] = map;

    // 执行并行clone
    var tasks = modules.map((e) => _createCloneTask(e)).toList(growable: false);

    try {
      await Future.wait(tasks);
    } catch (e) {
      return Either.left(CICDUnImplementError());
    }

    return Either.right(args);
  }

  Future<Either<ToolsError, bool>> _createCloneTask(ModuleEntity entity) async {
    var gitClone = GitClone(
        workDir: Directory('${settings.workSpace}/temp/${entity.moduleName}'),
        repoUrl: entity.repo.repoUrl);
    return gitClone.run();
  }
}

// TODO
/// 本地单测
class UnitStage extends CICDStage {
  UnitStage({required super.nameId});

  @override
  Future<Either<CICDError, Map<String, Object>>> run(Map<String, Object> args) {
    // TODO: implement run
    throw UnimplementedError();
  }
}

// TODO
/// sonar上传
class SonarStage extends CICDStage {
  SonarStage({required super.nameId});

  @override
  Future<Either<CICDError, Map<String, Object>>> run(Map<String, Object> args) {
    // TODO: implement run
    throw UnimplementedError();
  }
}

/// android aar发布
class AndroidPackageReleaseState extends CICDStage {
  AndroidPackageReleaseState() : super(nameId: 'AndroidPackageReleaseState');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    // 获取module
    var arg = args[CONFIG_MODULES];
    Logger.i(msg: '-----$args');

    return Either.right(args);
  }
}

/// ios pods发布
class IOSPackageReleaseState extends CICDStage {
  IOSPackageReleaseState() : super(nameId: 'IOSPackageReleaseState');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(Map<String, Object> args) {
    // TODO: implement run
    throw UnimplementedError();
  }
}
