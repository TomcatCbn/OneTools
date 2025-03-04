import 'dart:io';

import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_logger.dart';

import 'cicd_errors.dart';

mixin GradleAction {
  static const String _tag = 'gradle-action';

  // 发布到jfrog仓库, 依赖于gradle配置
  Future<Either<CICDError, bool>> artifactoryPublish(
      {required String workDir,
      required String moduleName,
      Map<String, String>? env}) async {
    var cmd = ArtifactoryPublishCMD(
        moduleName: moduleName, workDir: Directory(workDir), env: env);
    bool res = false;
    try {
      var either = await cmd.run();
      res = either.fold(ifLeft: (v) => false, ifRight: (v) => v);
    } catch (e) {
      Logger.e(msg: 'artifactoryPublish failed, $e', tag: _tag);
      return Either.left(CICDRuntimeError(e.toString()));
    }

    return Either.right(res);
  }
}
