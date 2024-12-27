import 'dart:io';

import 'package:platform_utils/platform_utils.dart';
import 'package:platform_utils/shell/shell_utils.dart';

import '../../utils/ext_string.dart';

/// 项目聚合根
class ProjectAggregate {
  /// 项目名字，唯一标识
  final String projectName;

  /// 项目描述
  final String projectDesc;

  /// 工作空间地址
  final String workDir;

  /// 项目包含的仓库
  final List<CodeRepoEntity> codeRepos;

  /// 该项目的工作空间地址
  String get projectDir => '$workDir/$projectName';

  ProjectAggregate({
    required this.projectName,
    required this.projectDesc,
    required this.workDir,
    required this.codeRepos,
  });

  /// 检查项目中的所有子模块
  Future<void> prepare() async {
    // 先检查工作路径
    var directory = Directory(projectDir);
    Logger.i(msg: '工作目录如下：${directory.path}');
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      Logger.i(msg: '初始化工作目录完成');
    }

    // gitlab dns无法解析，需要设置环境变量
    await GitProxy(proxy: 'http://127.0.0.1:7890', workDir: directory).run();

    var list = codeRepos.map((e) async {
      return e.prepare(directory);
    }).toList();
    await Future.wait(list);

    Logger.i(msg: 'project prepare finish...');
  }
}

class CodeRepoEntity {
  final QualityEntity qualityEntity;
  final GitEntity gitEntity;

  CodeRepoEntity({required this.qualityEntity, required this.gitEntity});

  Future<void> prepare(Directory workDir) async {
    // 检查目录是否存在
    final repoDir = Directory('${workDir.path}/${gitEntity.repoDirName}');
    if (repoDir.existsSync()) {
      // 更新，fetch，pull
      await gitEntity.fetch(repoDir);
      await gitEntity.pull(repoDir);
    } else {
      // clone
      await gitEntity.clone(workDir);
    }
    // 当前分支名称
    var gitQueryCurrentBranch = GitQueryCurrentBranch(workDir: repoDir);
    var eitherBranch = await gitQueryCurrentBranch.run();
    gitEntity.branch =
        eitherBranch.fold(ifLeft: (value) => 'null', ifRight: (value) => value);
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
