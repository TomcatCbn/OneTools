import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:process_runner/process_runner.dart';

import '../command/i_command.dart';
import '../log/platform_logger.dart';

/// shell 工具
class ShellUtils {
  static const String tag = 'ShellUtils';

  static Future<bool> hasShellCmd(String command) async {
    Logger.d(msg: 'run check shell cmd, $command', tag: tag);
    // 通过执行指令，检查版本，判断是否存在
    try {
      ProcessRunner processRunner = ProcessRunner();
      ProcessRunnerResult result = await processRunner.runProcess(
        [command, '--version'],
        printOutput: true,
      );

      if (result.exitCode == 0) {
        return true;
      }

      return false;
    } catch (e) {
      Logger.e(msg: 'hasShellCmd get error, $e', tag: tag);

      return false; // 捕获异常，表示指令不存在
    }
  }

  static Future<Either<ShellError, ProcessExecResult>> execCMD(
    List<String> commandLine,
    Directory workingDirectory, {
    Map<String, String>? environment,
  }) async {
    Logger.d(msg: 'run shell cmd, $commandLine', tag: tag);
    ProcessRunner processRunner = ProcessRunner(environment: environment);
    ProcessRunnerResult result = await processRunner.runProcess(
      commandLine,
      workingDirectory: workingDirectory,
      printOutput: true,
    );
    // ProcessResult result = await Process.run(
    //     commandLine.first, commandLine.sublist(1),
    //     workingDirectory: workingDirectory.path);

    if (result.exitCode == 0) {
      Logger.d(msg: 'run shell cmd success, $commandLine', tag: tag);
      return Either.right(
          ProcessExecResult(exitCode: 0, stdout: result.stdout));
    }

    Logger.e(msg: 'run shell cmd failed, $commandLine', tag: tag);
    return Either.left(ShellError(stderr: result.stderr));
  }
}

class ShellError extends ToolsError {
  static const int _baseOfShell = 1000;

  ShellError({String? stderr})
      : super(errorCode: _baseOfShell, errorMsg: 'ShellError: $stderr');
}

class ProcessExecResult {
  final int exitCode;

  final String? stdout;
  final String? stderr;

  ProcessExecResult(
      {required this.exitCode, this.stdout = '', this.stderr = ''});

  bool get isSuccess => exitCode == 0;
}
