import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_logger.dart';

import '../cicd_errors.dart';
import '../module.dart';
import '../stage_config.dart';
import 'cicd_stage.dart';

/// ios pods发布
class IOSPackageReleaseStage extends CICDStage {
  IOSPackageReleaseStage() : super(nameId: 'IOSPackageReleaseStage');

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    // TODO: @HSM @YUJIUSHENG
    // 获取module
    var modules = args[CONFIG_OPERATE_MODULES] as Map<String, ModuleEntity>;
    if (modules.isEmpty) {
      return Either.right(args);
    }
    Logger.i(msg: '$nameId, 准备执行${modules.length}个module发布');

    return Either.right(args);
  }
}
