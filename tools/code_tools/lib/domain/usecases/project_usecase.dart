import 'package:code_tools/domain/entities/project.dart';

import '../factory/project_factory.dart';
import '../repo/i_project_repo.dart';

class ProjectUseCase {
  final ProjectRepo repo;

  final ProjectFactory projectFactory;

  ProjectUseCase({required this.repo, required this.projectFactory});

  /// 从本地加载所有的项目
  Future<List<ProjectAggregate>> loadAllProjects() async {
    var allProjects = await repo.loadAllProject();
    return allProjects;
  }

  /// 从本地加载指定项目
  Future<ProjectAggregate?> loadProjectBy(String projectName) async {
    var projectAggregate = await repo.loadProject(projectName);
    return projectAggregate;
  }

  /// 根据json文件，创建对应的project
  ProjectAggregate createProjectBy(String json, String workDir) {
    return projectFactory.createProject(json, workDir);
  }

  Future<bool> addOrUpdateProject(ProjectAggregate project) async {
    bool exist = await repo.isProjectExist(project.projectName);
    if (exist) {
      // update
      return repo.updateProject(project);
    } else {
      return repo.addProject(project);
    }
  }
}
