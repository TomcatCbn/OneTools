import 'dart:io';

import 'package:code_tools/utils/ext_string.dart';
import 'package:platform_utils/platform_stream_enhance.dart';
import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_logger.dart';

/// 代表一个仓库实例
class CodeRepoEntity {
  /// 聚焦在仓库质量
  final QualityEntity qualityEntity;

  /// 聚焦在仓库的git信息
  final GitEntity gitEntity;

  /// 父目录
  final String workDir;

  /// 自身目录
  final String repoDir;

  BehaviorSubject<CodeRepoStatus> codeRepoStatus =
      BehaviorSubject.seeded(CodeRepoStatusIdle());

  CodeRepoEntity({
    required this.qualityEntity,
    required this.gitEntity,
    required this.workDir,
  }) : repoDir = '$workDir/${gitEntity.repoDirName}';

  CodeRepoStatus get status => codeRepoStatus.value;

  Future<void> prepare() async {
    if (status is CodeRepoStatusUpdating) {
      return;
    }

    try {
      // 检查目录是否存在
      var dir = Directory(repoDir);
      var exist = await dir.exists();
      if (exist) {
        // 更新，fetch，pull
        codeRepoStatus.sink.add(CodeRepoStatusUpdating(action: 'fetch'));
        await gitEntity.fetch(dir);
        codeRepoStatus.sink.add(CodeRepoStatusUpdating(action: 'pull'));
        await gitEntity.pull(dir);
      } else {
        // clone
        codeRepoStatus.sink.add(CodeRepoStatusUpdating(action: 'clone'));
        await gitEntity.clone(Directory(workDir));
      }
      // 当前分支名称
      codeRepoStatus.sink.add(CodeRepoStatusUpdating(action: 'query branch'));
      var gitQueryCurrentBranch = GitQueryCurrentBranch(workDir: dir);
      var eitherBranch = await gitQueryCurrentBranch.run();
      gitEntity.branch = eitherBranch.fold(
          ifLeft: (value) => 'null', ifRight: (value) => value);
      codeRepoStatus.sink
          .add(CodeRepoStatusUpdated(updateTime: DateTime.now()));
    } catch (e) {
      Logger.e(msg: 'prepare ${gitEntity.repoDirName} failed, $e');
      codeRepoStatus.sink.add(CodeRepoStatusFailed(reason: '$e'));
    }
  }
}

/// 仓库代码质量
/// 包括单测覆盖率、代码静态扫描结果等
class QualityEntity {
  const QualityEntity();

  static const QualityEntity empty = QualityEntity();
}

class GitEntity {
  /// git 地址
  final String gitRepo;

  /// 仓库目录名称
  final String repoDirName;

  /// 当前分支
  String branch = '';

  GitEntity({required this.gitRepo}) : repoDirName = gitRepo.extractName;

  List<String> allBranches = [];

  /// 打tag
  Future<bool> tag(String tag) async {
    return false;
  }

  /// 切换分支
  /// [branch] 目标分支
  Future<bool> checkout(String branch) async {
    return false;
  }

  /// 获取最新git信息
  Future<bool> fetch(Directory workDir) async {
    var gitFetch = GitFetch(workDir: workDir);
    var either = await gitFetch.run();
    bool res = either.fold(ifLeft: (value) {
      return false;
    }, ifRight: (value) {
      return true;
    });

    return res;
  }

  /// 拉取最新git代码
  Future<bool> pull(Directory workDir) async {
    var gitPull = GitPull(workDir: workDir);
    var either = await gitPull.run();
    bool res = either.fold(ifLeft: (value) {
      return false;
    }, ifRight: (value) {
      return true;
    });

    return res;
  }

  Future<bool> clone(Directory workDir) async {
    var gitClone = GitClone(workDir: workDir, repoUrl: gitRepo);
    var either = await gitClone.run();
    bool res = either.fold(ifLeft: (value) {
      return false;
    }, ifRight: (value) {
      return true;
    });

    return res;
  }
}

sealed class CodeRepoStatus {}

final class CodeRepoStatusUpdating extends CodeRepoStatus {
  /// 当前的操作
  final String action;

  CodeRepoStatusUpdating({required this.action});
}

final class CodeRepoStatusUpdated extends CodeRepoStatus {
  final DateTime updateTime;

  CodeRepoStatusUpdated({required this.updateTime});
}

final class CodeRepoStatusFailed extends CodeRepoStatus {
  final String reason;

  CodeRepoStatusFailed({required this.reason});
}

final class CodeRepoStatusIdle extends CodeRepoStatus {}
