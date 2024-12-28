import 'dart:convert';

import 'package:code_tools/domain/entities/project.dart';

import '../entities/code_repo.dart';

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
    var projectAggregate = ProjectAggregate(
      projectName: projectName,
      projectDesc: projectDesc,
      workDir: workDir,
    );
    for (final codeRepoT in codeReposT) {
      var codeRepoEntity = CodeRepoEntity(
          qualityEntity: QualityEntity.empty,
          gitEntity: GitEntity(gitRepo: codeRepoT['repoUrl']),
          workDir: projectAggregate.projectDir);
      projectAggregate.addCodeRepo(codeRepoEntity);
    }

    return projectAggregate;
  }
}
