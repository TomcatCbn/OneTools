import '../entities/project.dart';

abstract class ProjectRepo {
  Future<bool> addProject(ProjectAggregate project);

  Future<bool> updateProject(ProjectAggregate project);

  Future<bool> removeProject(ProjectAggregate project);

  Future<ProjectAggregate?> loadProject(String projectName);

  Future<bool> contains(String projectName);

  /// 从本地加载所有的project
  Future<List<ProjectAggregate>> loadAllProject();

  Future<bool> isProjectExist(String projectName);

  Future<bool> removeCodeRepo(String codeRepoName);
}
