import 'dart:convert';

import 'package:code_tools/domain/entities/project.dart';
import 'package:code_tools/utils/ext_string.dart';

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
      var codeRepoUrl = codeRepoT['repoUrl'] as String;
      var codeRepoName = codeRepoUrl.extractName;
      var codeRepoEntity = CodeRepoEntity(
          qualityEntity: QualityEntity.empty,
          gitEntity: GitEntity(
              gitRepo: codeRepoUrl, repoDirName: codeRepoName),
          workDir: projectAggregate.projectDir,
          codeRepoName: codeRepoName);
      projectAggregate.addCodeRepo(codeRepoEntity);
    }

    return projectAggregate;
  }
}
