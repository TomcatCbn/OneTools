import 'package:dart_either/dart_either.dart';

import '../../log/platform_logger.dart';
import '../../shell/shell_utils.dart';
import '../i_command.dart';

const String _tag = 'GRADLE CMD';
const String _gradleCMD = './gradlew';
const String _jfrogUploadCMD = 'artifactoryPublish';
const String _publishLocalCMD = 'publish';

sealed class GradleCMD<R> extends ShellCommand<R> {
  GradleCMD({required super.workDir});
}

class ArtifactoryPublishCMD extends GradleCMD<bool> {
  final String moduleName;
  final Map<String, String>? env;

  ArtifactoryPublishCMD(
      {required this.moduleName, required super.workDir, this.env});

  @override
  Future<Either<E, bool>> run<E extends ToolsError>() async {
    Logger.d(msg: 'run artifactory publish, $workDir, $moduleName', tag: _tag);
    // check java version
    await ShellUtils.execCMD(['java', '--version'], workDir, environment: env);
    // ./gradlew :moduleName:artifactoryPublish
    var either = await ShellUtils.execCMD(
        [_gradleCMD, ':$moduleName:$_jfrogUploadCMD'], workDir,
        environment: env);

    return either.fold(
        ifLeft: (l) => Left(l as E), ifRight: (r) => Right(r.isSuccess));
  }
}
