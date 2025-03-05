import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_logger.dart';

import '../cicd_errors.dart';
import '../module.dart';
import '../stage_config.dart';
import 'cicd_stage.dart';

/// ios ipa
class IOSIPAReleaseStage extends CICDStage {
  IOSIPAReleaseStage() : super(nameId: 'IOSIPAReleaseStage');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    // 获取module
    var modules = args[CONFIG_OPERATE_MODULES] as Map<String, ModuleEntity>;
    if (modules.isEmpty) {
      return Either.right(args);
    }

    Logger.i(msg: '$nameId, 准备执行ipa构建');
    // 工作目录
    final String workDir = args[CONFIG_PIPELINE_WORKSPACE] as String;
    final Map<String, String>? env =
        args[CONFIG_PIPELINE_ENVIRONMENT] as Map<String, String>?;
    var list = modules.values
        .map((e) => _createXCodeTask(e, '$workDir/${e.moduleName}', env))
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

  Future<Either<CICDError, void>> _createXCodeTask(
      ModuleEntity entity, String workDir, Map<String, String>? env) async {
    // TODO: @SAIMING JIUSHENG
    return Either.right(null);
  }
}
