import 'dart:io';

import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_logger.dart';

import '../cicd_errors.dart';
import '../module.dart';
import '../stage_config.dart';
import 'cicd_stage.dart';

/// 确认模块依赖关系, 并处理
class DependencyCheckForAndroidStage extends CICDStage {
  DependencyCheckForAndroidStage()
      : super(nameId: 'DependencyCheckForAndroidStage');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    if (!args.containsKey(CONFIG_OPERATE_MODULES)) {
      Logger.e(msg: '未选中任何Module');
      return Either.left(CICDRuntimeError('module empty'));
    }

    final modules = args[CONFIG_OPERATE_MODULES] as Map<String, ModuleEntity>;
    // 工作目录
    final String workDir = args[CONFIG_PIPELINE_WORKSPACE] as String;
    Logger.i(msg: '$nameId, 一共${modules.length}个模块');
    // 处理依赖关系
    final Map<String, ModuleEntity> allModules =
    args[CONFIG_ALL_MODULES] as Map<String, ModuleEntity>;
    List<List<ModuleEntity>> deps = modules.values.map((e) {
      return e.dependencyModules.map((d) {
        final m = allModules[d] as ModuleEntity;
        return m;
      }).toList(growable: false);
    }).toList();
    var tasks = deps
        .expand((list) => list)
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

// 确认模块依赖关系, 并处理
class DependencyCheckForIOSStage extends CICDStage {
  DependencyCheckForIOSStage() : super(nameId: 'DependencyCheckForIOSStage');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    return Either.right(args);
  }
}