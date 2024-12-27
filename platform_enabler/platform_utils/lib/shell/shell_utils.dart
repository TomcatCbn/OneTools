import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:process_runner/process_runner.dart';

import '../command/i_command.dart';
import '../log/platform_logger.dart';

/// shell 工具
class ShellUtils {
  static const String tag = 'ShellUtils';
  static ProcessRunner processRunner = ProcessRunner();

  static Future<bool> hasShellCmd(String command) async {
    Logger.d(msg: 'run check shell cmd, $command', tag: tag);
    // 通过执行指令，检查版本，判断是否存在
    try {
      final result = await processRunner
          .runProcess([command, '--version'], printOutput: true);

      if (result.exitCode == 0) {
        return true;
      }

      return false;
    } catch (e) {
      Logger.e(msg: 'hasShellCmd get error, $e', tag: tag);

      return false; // 捕获异常，表示指令不存在
    }
  }

  static Future<Either<ShellError, ProcessResult>> execCMD(
    List<String> commandLine,
    Directory workingDirectory,
  ) async {
    Logger.d(msg: 'run shell cmd, $commandLine', tag: tag);
    var processRunnerResult = await processRunner.runProcess(commandLine,
        workingDirectory: workingDirectory, printOutput: true);

    if (processRunnerResult.exitCode == 0) {
      Logger.d(msg: 'run shell cmd success, $commandLine', tag: tag);
      return Either.right(
          ProcessResult(exitCode: 0, stdout: processRunnerResult.stdout));
    }

    Logger.e(msg: 'run shell cmd failed, $commandLine', tag: tag);
    return Either.left(ShellError(stderr: processRunnerResult.stderr));
  }

  static Future<bool> enterDir(Directory workingDirectory) async {
    var processRunnerResult =
        await processRunner.runProcess(['cd', '${workingDirectory.absolute}']);
    return processRunnerResult.exitCode == 0;
  }
}

class ShellError extends ToolsError {
  static const int _baseOfShell = 1000;

  ShellError({String? stderr}) : super(errorCode: _baseOfShell, errorMsg: 'ShellError: $stderr');
}

class ProcessResult {
  final int exitCode;

  final String? stdout;
  final String? stderr;

  ProcessResult({required this.exitCode, this.stdout = '', this.stderr = ''});

  bool get isSuccess => exitCode == 0;
}
