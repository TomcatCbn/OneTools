import 'dart:io';

import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_logger.dart';

import '../cicd_errors.dart';
import '../module.dart';
import '../stage_config.dart';
import 'cicd_stage.dart';

/// 代码拉取，并切换分支
/// 可以是单个模块，也可以是多个模块
class CodeFetchStage extends CICDStage {
  CodeFetchStage() : super(nameId: 'CodeFetchStage');

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
