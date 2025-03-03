import 'dart:io';

import 'package:dart_either/dart_either.dart';

/// 所有行为指令的基类
abstract class Command<R> {
  /// 不会抛出异常
  /// 如果成功则返回R
  /// 如果失败返回E
  Future<Either<E, R>> run<E extends ToolsError>();
}

abstract class ShellCommand<R> extends Command<R> {
  /// 工作目录
  final Directory workDir;

  ShellCommand({required this.workDir});
}

abstract class ToolsError {
  /// 按照各个大功能维度划分code
  final int errorCode;
  final String errorMsg;

  ToolsError({required this.errorCode, required this.errorMsg});
}

const int _baseCode = -1000;

/// 入参无效
const int paramsInvalid = _baseCode - 1;
const int commandLineInvalid = _baseCode - 2;
const int commandNoPermission = _baseCode - 3;

class CommonError extends ToolsError {
  CommonError.paramsInvalid()
      : super(errorCode: paramsInvalid, errorMsg: '入参无效');

  CommonError.shellCMDNotExist()
      : super(errorCode: commandLineInvalid, errorMsg: '命令不存在');

  CommonError.noPermission() :super(errorCode: commandNoPermission, errorMsg: '没有权限');

  CommonError.unknown() : super(errorCode: _baseCode, errorMsg: 'unknown');
}
