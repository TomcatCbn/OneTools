import '../entities/project.dart';

abstract class ProjectRepo {
  Future<bool> addProject(ProjectAggregate project);

  Future<bool> updateProject(ProjectAggregate project);

  Future<bool> removeProject(ProjectAggregate project);

  Future<ProjectAggregate?> loadProject(String projectName, String workDir);

  /// 从本地加载所有的project
  Future<List<ProjectAggregate>> loadAllProject({String workDir = ''});

  Future<bool> isProjectExist(String projectName, String workDir);

  Future<bool> removeCodeRepo(String codeRepoName);
}
