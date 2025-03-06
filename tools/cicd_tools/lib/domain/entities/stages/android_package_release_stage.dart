import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_logger.dart';
import 'package:platform_utils/platform_utils.dart';

import '../cicd_errors.dart';
import '../module.dart';
import '../stage_config.dart';
import 'cicd_stage.dart';

/// android aar发布
class AndroidPackageReleaseStage extends CICDStage {
  AndroidPackageReleaseStage() : super(nameId: 'AndroidPackageReleaseStage');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    // 获取module
    var modules = args[CONFIG_OPERATE_MODULES] as Map<String, ModuleEntity>;
    if (modules.isEmpty) {
      return Either.right(args);
    }

    Logger.i(msg: '$nameId, 准备执行${modules.length}个module发布');
    // 工作目录
    final String workDir = args[CONFIG_PIPELINE_WORKSPACE] as String;
    final Map<String, String>? env =
        args[CONFIG_PIPELINE_ENVIRONMENT] as Map<String, String>?;

    // 处理发布版本信息
    var getVersionTasks = modules.values.map((e) {
      return _createGetPublishVersionTask(e, '$workDir/${e.moduleName}', env);
    }).toList(growable: false);
    try {
      await Future.wait(getVersionTasks);
    } catch (e) {
      return Either.left(CICDUnImplementError());
    }

    var list = modules.values
        .map((e) => _createGradleTask(e, '$workDir/${e.moduleName}', env))
        .toList(growable: false);
    try {
      var results = await Future.wait(list);
      try {
        var error = results.firstWhere((r) => r.isLeft);
        return Either.left(
            CICDRuntimeError((error as Left<CICDError, void>).value.msg));
      } catch (e) {
        // ignore
      }
    } catch (e) {
      Logger.e(msg: '$nameId, failed, $e');
      return Either.left(CICDRuntimeError(e.toString()));
    }

    return Either.right(args);
  }

  Future<Either<CICDError, void>> _createGradleTask(
    ModuleEntity entity,
    String workDir,
    Map<String, String>? env,
  ) async {
    Logger.i(
        msg:
            '执行${entity.moduleName}的发布，branch: ${entity.targetBranch}, tag: ${entity.targetTag}');
    return await entity.artifactoryPublish(
        workDir: workDir, moduleName: entity.repo.path, env: env);
  }

  Future<Either<CICDError, String>> _createGetPublishVersionTask(
    ModuleEntity entity,
    String workDir,
    Map<String, String>? env,
  ) async {
    final tag = await entity.getPublishVersion(
        workDir: workDir, moduleName: entity.repo.path, env: env);
    entity.targetTag = tag.fold(ifLeft: (v) => '', ifRight: (v) => v);
    return tag;
  }
}
