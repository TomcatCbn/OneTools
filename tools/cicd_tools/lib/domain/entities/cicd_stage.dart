// CICD Stage抽象
import 'dart:io';

import 'package:cicd_tools/domain/entities/gradle_action.dart';
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

  @override
  String toString() {
    return 'CICDStage{nameId: $nameId}';
  }
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
  CodeFetchStage() : super(nameId: 'CodeFetchStage');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    if (!args.containsKey(CONFIG_MODULES)) {
      Logger.e(msg: '未选中任何Module');
      return Either.left(CICDRuntimeError('module empty'));
    }
    final modules = args[CONFIG_MODULES] as Map<String, ModuleEntity>;
    // 工作目录
    final String workDir = args[CONFIG_PIPELINE_WORKSPACE] as String;
    Logger.i(msg: '$nameId, 一共${modules.length}个模块');
    // 执行并行clone
    var tasks = modules.values
        .map((e) => _createCloneTask(e, e.targetBranch, workDir))
        .toList(growable: false);
    try {
      await Future.wait(tasks);
    } catch (e) {
      return Either.left(CICDUnImplementError());
    }

    return Either.right(args);
  }

  Future<Either<ToolsError, bool>> _createCloneTask(
      ModuleEntity entity, String branch, String workDir) async {
    var gitClone = GitClone(
      workDir: Directory(workDir),
      repoUrl: entity.repo.repoUrl,
      branch: branch,
      dirName: entity.moduleName,
    );
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
class AndroidPackageReleaseState extends CICDStage with GradleAction {
  AndroidPackageReleaseState() : super(nameId: 'AndroidPackageReleaseState');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    // 获取module
    var modules = args[CONFIG_MODULES] as Map<String, ModuleEntity>;
    if (modules.isEmpty) {
      return Either.right(args);
    }

    Logger.i(msg: '$nameId, 准备执行${modules.length}个module发布');
    // 工作目录
    final String workDir = args[CONFIG_PIPELINE_WORKSPACE] as String;
    var list = modules.values
        .map((e) => _createGradleTask(e, '$workDir/${e.moduleName}'))
        .toList(growable: false);
    try {
      await Future.wait(list);
    } catch (e) {
      Logger.e(msg: '$nameId, failed, $e');
      return Either.left(CICDRuntimeError(e.toString()));
    }

    return Either.right(args);
  }

  Future<Either<CICDError, void>> _createGradleTask(
      ModuleEntity entity, String workDir) {
    return entity.artifactoryPublish(
        workDir: workDir, moduleName: entity.repo.path);
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
