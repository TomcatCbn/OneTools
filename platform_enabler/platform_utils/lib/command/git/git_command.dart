import 'package:dart_either/dart_either.dart';
import 'package:platform_utils/command/i_command.dart';
import 'package:platform_utils/shell/shell_utils.dart';

import '../../log/platform_logger.dart';

const String _tag = 'GIT CMD';
const String _gitCMD = 'git';
const String _gitCMDClone = 'clone';
const String _gitCMDFetch = 'fetch';
const String _gitCMDBranch = 'branch';
const String _gitCMDPull = 'pull';
const String _gitCMDCheckout = 'checkout';
const String _gitCMDTag = 'tag';
const String _gitCMDPush = 'push';
const String _gitCMDConfig = 'config';

abstract class GitCMD<R> extends ShellCommand<R> {
  GitCMD({required super.workDir});
}

class GitClone extends GitCMD<bool> {
  final String repoUrl;

  GitClone({required super.workDir, required this.repoUrl});

  @override
  Future<Either<E, bool>> run<E extends ToolsError>() async {
    Logger.d(msg: 'run git clone, $repoUrl, $workDir', tag: _tag);
    if (repoUrl.isEmpty) {
      return Left(CommonError.paramsInvalid() as E);
    }

    var eitherRes =
        await ShellUtils.execCMD([_gitCMD, _gitCMDClone, repoUrl], workDir);
    return eitherRes.fold(
        ifLeft: (l) => Either.left(l as E),
        ifRight: (r) => Either.right(r.isSuccess));
  }
}

class GitFetch extends GitCMD<bool> {
  GitFetch({required super.workDir});

  @override
  Future<Either<E, bool>> run<E extends ToolsError>() async {
    Logger.d(msg: 'run git fetch, $workDir', tag: _tag);

    var eitherRes = await ShellUtils.execCMD([_gitCMD, _gitCMDFetch], workDir);
    return eitherRes.fold(
        ifLeft: (l) => Left(l as E), ifRight: (r) => Right(r.isSuccess));
  }
}

class GitPull extends GitCMD<bool> {
  GitPull({required super.workDir});

  @override
  Future<Either<E, bool>> run<E extends ToolsError>() async {
    Logger.d(msg: 'run git pull, $workDir', tag: _tag);

    var eitherRes =
        await ShellUtils.execCMD([_gitCMD, _gitCMDPull, '--rebase'], workDir);

    return eitherRes.fold(
        ifLeft: (l) => Left(l as E), ifRight: (r) => Right(r.isSuccess));
  }
}

class GitCheckout extends GitCMD<bool> {
  final String branchName;
  final bool hasLocalBranch;
  final String newBranchName;

  GitCheckout({
    required super.workDir,
    required this.branchName,
    required this.hasLocalBranch,
    this.newBranchName = '',
  });

  @override
  Future<Either<E, bool>> run<E extends ToolsError>() async {
    Logger.d(msg: 'run git checkout, $workDir, $branchName', tag: _tag);
    // 检查是否是远端分支
    // remote/origin
    if (branchName.isEmpty) {
      return Either.left(CommonError.paramsInvalid() as E);
    }
    Either<ShellError, ProcessExecResult> eitherRes;
    if (!hasLocalBranch) {
      eitherRes = await ShellUtils.execCMD(
          [_gitCMD, _gitCMDCheckout, '-b', newBranchName, branchName], workDir);
    } else {
      eitherRes = await ShellUtils.execCMD(
          [_gitCMD, _gitCMDCheckout, branchName], workDir);
    }

    return eitherRes.fold(
        ifLeft: (l) => Left(l as E), ifRight: (r) => Right(r.isSuccess));
  }
}

class GitTag extends GitCMD<String> {
  final String tag;

  GitTag({required super.workDir, required this.tag});

  @override
  Future<Either<E, String>> run<E extends ToolsError>() async {
    if (tag.isEmpty) {
      return Either.left(CommonError.paramsInvalid() as E);
    }
    var either = await ShellUtils.execCMD([_gitCMD, _gitCMDTag, tag], workDir);
    if (either.isRight) {
      either =
          await ShellUtils.execCMD([_gitCMD, _gitCMDPush, '--tag'], workDir);
    }

    return either.fold(
        ifLeft: (l) => Left(l as E),
        ifRight: (r) => Right((r.stdout ?? 'unknown').toString().trim()));
  }
}

class GitBranch extends GitCMD<String> {
  final String branchName;

  GitBranch({required super.workDir, required this.branchName});

  @override
  Future<Either<E, String>> run<E extends ToolsError>() async {
    if (branchName.isEmpty) {
      return Either.left(CommonError.paramsInvalid() as E);
    }
    var either =
        await ShellUtils.execCMD([_gitCMD, _gitCMDBranch, branchName], workDir);
    // 推送到远端，关联本地分支
    if (either.isRight) {
      either = await ShellUtils.execCMD(
          [_gitCMD, _gitCMDPush, '--set-upstream', 'origin', branchName],
          workDir);
    }

    return either.fold(
        ifLeft: (l) => Left(l as E),
        ifRight: (r) => Right((r.stdout ?? 'unknown').toString().trim()));
  }
}

class GitQueryCurrentBranch extends GitCMD<String> {
  GitQueryCurrentBranch({required super.workDir});

  @override
  Future<Either<E, String>> run<E extends ToolsError>() async {
    var either = await ShellUtils.execCMD(
        [_gitCMD, _gitCMDBranch, '--show-current'], workDir);

    return either.fold(
        ifLeft: (l) => Left(l as E),
        ifRight: (r) => Right((r.stdout ?? 'unknown').toString().trim()));
  }
}

class GitQueryAllBranch extends GitCMD<List<String>> {
  GitQueryAllBranch({required super.workDir});

  @override
  Future<Either<E, List<String>>> run<E extends ToolsError>() async {
    var either =
        await ShellUtils.execCMD([_gitCMD, _gitCMDBranch, '-a'], workDir);
    if (either.isLeft) {
      return Left((either as Left).value);
    }
    var stdout =
        ((either as Right<ShellError, ProcessExecResult>).value.stdout ?? '')
            .trim();

    try {
      // 解析输出
      final branches = stdout
          .toString()
          .split('\n') // 分割为行
          .map((line) => line.trim()) // 去除首尾空格
          .where((line) => line.isNotEmpty) // 过滤掉空行
          .map((line) {
        // 处理分支名称
        if (line.startsWith('*')) {
          return line.substring(1).trim(); // 去掉当前分支的 '*' 符号
        }
        return line;
      }).toList();

      return Either.right(branches);
    } catch (e) {
      return Either.left(ShellError(stderr: '解析resp出错') as E);
    }
  }
}

class GitProxy extends GitCMD<bool> {
  final String proxy;

  GitProxy({required this.proxy, required super.workDir});

  @override
  Future<Either<E, bool>> run<E extends ToolsError>() async {
    await ShellUtils.execCMD(
        [_gitCMD, _gitCMDConfig, '--global', 'http.proxy', proxy], workDir);
    await ShellUtils.execCMD(
        [_gitCMD, _gitCMDConfig, '--global', 'https.proxy', proxy], workDir);

    return const Right(true);
  }
}
