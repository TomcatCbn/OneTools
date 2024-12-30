import 'package:code_tools/domain/entities/project.dart';
import 'package:code_tools/domain/repo/i_project_repo.dart';
import 'package:code_tools/infra/datasource/project_data_source.dart';

class ProjectRepoImpl implements ProjectRepo {
  final ProjectLocalDataSource _localDataSource;

  ProjectRepoImpl({required ProjectLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<bool> addProject(ProjectAggregate project) {
    return _localDataSource.addProject(project);
  }

  @override
  Future<List<ProjectAggregate>> loadAllProject() async {
    return _localDataSource.loadAllProject();
  }

  @override
  Future<ProjectAggregate?> loadProject(String projectName) {
    return _localDataSource.loadProject(projectName);
  }

  @override
  Future<bool> removeProject(ProjectAggregate project) {
    return _localDataSource.removeProject(project);
  }

  @override
  Future<bool> updateProject(ProjectAggregate project) {
    return _localDataSource.updateProject(project);
  }

  @override
  Future<bool> contains(String projectName) async {
    var project = await _localDataSource.loadProject(projectName);
    if (project != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> isProjectExist(String projectName) {
    return _localDataSource.isProjectExist(projectName);
  }

  @override
  Future<bool> removeCodeRepo(String codeRepoName) {
    return _localDataSource.removeCodeRepo(codeRepoName);
  }
}
