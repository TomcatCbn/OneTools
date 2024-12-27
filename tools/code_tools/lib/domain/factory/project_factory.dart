import 'dart:convert';
import 'dart:io';

import 'package:code_tools/domain/entities/project.dart';

abstract class ProjectFactory {
  /// 根据配置文件创建一个项目
  ProjectAggregate createProject(String jsonStr, String workDir);
}

class ProjectFactoryImpl implements ProjectFactory {
  @override
  ProjectAggregate createProject(String jsonStr, String workDir) {
    var decode = json.decode(jsonStr);
    var projectName = decode['projectName'] as String;
    var projectDesc = decode['projectDesc'] as String;
    var codeReposT = decode['codeRepos'] as List<dynamic>;
    var codeRepos = codeReposT
        .map((codeRepo) => CodeRepoEntity(
            qualityEntity: QualityEntity.empty,
            gitEntity: GitEntity(gitRepo: codeRepo['repoUrl'])))
        .toList();
    return ProjectAggregate(
      projectName: projectName,
      projectDesc: projectDesc,
      workDir: workDir,
      codeRepos: codeRepos,
    );
  }
}
