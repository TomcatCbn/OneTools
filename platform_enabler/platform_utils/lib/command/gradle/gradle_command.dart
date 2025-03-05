import 'package:dart_either/dart_either.dart';

import '../../log/platform_logger.dart';
import '../../shell/shell_utils.dart';
import '../i_command.dart';

const String _tag = 'GRADLE CMD';
const String _gradleCMD = './gradlew';
const String _jfrogUploadCMD = 'artifactoryPublish';
const String _getPublishVersion = 'getPublishVersion';
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

class GradlePublishVersionCMD extends GradleCMD<String> {
  final String moduleName;
  final Map<String, String>? env;

  GradlePublishVersionCMD(
      {required this.moduleName, required super.workDir, this.env});

  @override
  Future<Either<E, String>> run<E extends ToolsError>() async {
    Logger.d(msg: 'run get publish version, $workDir, $moduleName', tag: _tag);
    // ./gradlew :moduleName:artifactoryPublish
    var either = await ShellUtils.execCMD(
        [_gradleCMD, ':$moduleName:$_getPublishVersion'], workDir,
        environment: env);

    // getPublishVersion:0.1.0
    final tag = either.fold(ifLeft: (l) {
      return '';
    }, ifRight: (r) {
      return extractVersion(r.stdout ?? '');
    });

    return Either.right(tag);
  }

  String extractVersion(String output) {
    List<String> lines = output.split('\n');
    for (String line in lines) {
      if (line.startsWith('getPublishVersion:')) {
        List<String> parts = line.split(':');
        return parts[1];
      }
    }
    return '';
  }
}
