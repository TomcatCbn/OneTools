import 'dart:io';

import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_logger.dart';

import '../cicd_errors.dart';
import '../module.dart';
import '../stage_config.dart';
import 'cicd_stage.dart';

/// 仓库打tag，内部有一个依赖，需要获取到具体的tag
class TAGStage extends CICDStage {
  TAGStage() : super(nameId: 'TAGStage');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    // 这里已经可以通过module获取publish信息
    if (!args.containsKey(CONFIG_OPERATE_MODULES)) {
      return Either.left(CICDRuntimeError('没有操作的modules'));
    }

    var modules = args[CONFIG_OPERATE_MODULES] as Map<String, ModuleEntity>;
    if (modules.isEmpty) {
      return Either.right(args);
    }
    // 工作目录
    final String workDir = args[CONFIG_PIPELINE_WORKSPACE] as String;

    var list = modules.values
        .map((e) => _createTagTask(e, e.targetTag, '$workDir/${e.moduleName}'))
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

  Future<Either<ToolsError, String>> _createTagTask(
      ModuleEntity entity, String tag, String workDir) async {
    var gitTag = await GitTag(
      workDir: Directory(workDir),
      tag: tag,
    ).run();

    return gitTag;
  }
}
