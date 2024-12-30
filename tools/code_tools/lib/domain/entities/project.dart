import 'dart:async';
import 'dart:io';

import 'package:platform_utils/platform_utils.dart';

import 'code_repo.dart';

/// 项目聚合根
class ProjectAggregate {
  /// 项目名字，唯一标识
  final String projectName;

  /// 项目描述
  final String projectDesc;

  /// 工作空间地址
  final String workDir;

  /// 项目包含的仓库
  final List<CodeRepoEntity> codeRepos = [];

  /// 该项目的工作空间地址
  String get projectDir => '$workDir/$projectName';

  ProjectAggregate({
    required this.projectName,
    required this.projectDesc,
    required this.workDir,
  });

  ProjectAggregate.fromDb({
    required this.projectName,
    required this.projectDesc,
    required this.workDir,
    required List<CodeRepoEntity> codeRepoList,
  }) {
    codeRepos.addAll(codeRepoList);
  }

  /// 配置项目中的所有子模块
  Future<void> config() async {
    // 先检查工作路径
    var directory = Directory(projectDir);
    Logger.i(msg: '工作目录如下：${directory.path}');
    var exist = await directory.exists();
    if (!exist) {
      await directory.create(recursive: true);
      Logger.i(msg: '配置工作目录完成');
    }

    // gitlab dns无法解析，需要设置环境变量
    if (projectName.contains('cea')) {
      // cea
      await GitProxy(proxy: 'http://10.231.16.102:3192', workDir: directory)
          .run();
    } else {
      await GitProxy(proxy: 'http://127.0.0.1:7890', workDir: directory).run();
    }

    Logger.i(msg: 'project config finish...');
  }

  void addCodeRepo(CodeRepoEntity codeRepo) {
    codeRepos.add(codeRepo);
  }

  void removeCodeRepo(String codeRepoName) {
    codeRepos.removeWhere((c) => c.codeRepoName == codeRepoName);
  }
}
