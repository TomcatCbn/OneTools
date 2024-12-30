import 'dart:io';

import 'package:code_tools/domain/entities/git_action.dart';
import 'package:code_tools/utils/ext_string.dart';
import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_logger.dart';
import 'package:platform_utils/platform_stream_enhance.dart';

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

  /// 唯一标识
  final String codeRepoName;

  BehaviorSubject<CodeRepoStatus> codeRepoStatus =
      BehaviorSubject.seeded(CodeRepoStatusIdle());

  CodeRepoEntity({
    required this.qualityEntity,
    required this.gitEntity,
    required this.workDir,
    required this.codeRepoName,
  }) : repoDir = '$workDir/${gitEntity.repoDirName}';

  CodeRepoStatus get status => codeRepoStatus.value;

  Future<void> prepare({bool force = false}) async {
    if (status is CodeRepoStatusUpdating) {
      return;
    }

    // 如果已在30s内更新，则也忽略
    if (!force && status is CodeRepoStatusUpdated) {
      if ((DateTime.now()
                  .difference((status as CodeRepoStatusUpdated).updateTime))
              .inSeconds <=
          30) {
        return;
      }
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

  /// [action]
  /// 根据[action]，决定了哪些参数有值
  Future<void> execGitCMD(GitAction action,
      {String? branchName, String? tagName}) async {
    Directory wd = Directory(repoDir);
    try {
      switch (action) {
        case GitAction.checkout:
          codeRepoStatus.sink
              .add(CodeRepoStatusUpdating(action: 'checkout $branchName'));
          await gitEntity.checkout(wd, branchName ?? '');
          break;
        case GitAction.pull:
          codeRepoStatus.sink.add(CodeRepoStatusUpdating(action: 'pull'));
          await gitEntity.pull(wd);
          break;
        case GitAction.tag:
          codeRepoStatus.sink
              .add(CodeRepoStatusUpdating(action: 'tag $tagName'));
          await gitEntity.tag(wd, tagName ?? '');
          break;
      }

      codeRepoStatus.sink
          .add(CodeRepoStatusUpdated(updateTime: DateTime.now()));
    } catch (e) {
      codeRepoStatus.sink.add(CodeRepoStatusFailed(reason: e.toString()));
    }
  }

  @override
  String toString() {
    return 'CodeRepoEntity{gitEntity: $gitEntity, repoDir: $repoDir}';
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

  GitEntity({required this.gitRepo, required this.repoDirName});

  List<String> allBranches = [];

  /// 打tag
  Future<bool> tag(Directory workDir, String tag) async {
    var gitCMD = GitTag(workDir: workDir, tag: tag);
    var either = await gitCMD.run();
    bool res = either.fold(ifLeft: (value) {
      return false;
    }, ifRight: (value) {
      return true;
    });
    return res;
  }

  /// 切换分支
  /// [branch] 目标分支
  Future<bool> checkout(Directory workDir, String branch) async {
    // 如果本地已存在branch，则改为本地分支，不然git指令会报错
    GitCheckout gitCMD;
    if (branch.isRemoteBranch) {
      var localBranch = branch.toLocalBranch;
      bool hasLocalBranch = false;
      try {
        allBranches.firstWhere((e) {
          return e == localBranch;
        });
        hasLocalBranch = true;
        branch = localBranch;
        // 当前分支已是，则返回成功
        if (this.branch == localBranch) {
          return true;
        }
      } catch (e) {
        // ignore
      }
      gitCMD = GitCheckout(
          workDir: workDir,
          branchName: branch,
          newBranchName: localBranch,
          hasLocalBranch: hasLocalBranch);
    } else {
      gitCMD = GitCheckout(
          workDir: workDir, branchName: branch, hasLocalBranch: true);
    }

    var either = await gitCMD.run();
    bool res = either.fold(ifLeft: (value) {
      return false;
    }, ifRight: (value) {
      this.branch = branch.toLocalBranch;
      return true;
    });

    if (branch.isRemoteBranch) {
      await queryAllBranches(workDir);
    }

    return res;
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

    // 并更新所有分支信息
    await queryAllBranches(workDir);

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

    await queryAllBranches(Directory('${workDir.path}/$repoDirName'));

    return res;
  }

  Future<void> queryAllBranches(Directory workDir) async {
    // 并更新所有分支信息
    var gitBranch = GitQueryAllBranch(workDir: workDir);
    var queryEither = await gitBranch.run();
    if (queryEither.isRight) {
      // 更新
      List<String> branches = (queryEither as Right).value;
      allBranches
        ..clear()
        ..addAll(branches);
    }
  }

  @override
  String toString() {
    return 'GitEntity{branch: $branch, allBranches: $allBranches}';
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
