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
  Future<List<ProjectAggregate>> loadAllProject({String workDir = ''}) async {
    return _localDataSource.loadAllProject(workDir);
  }

  @override
  Future<ProjectAggregate?> loadProject(String projectName, String workDir) {
    return _localDataSource.loadProject(projectName, workDir);
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
  Future<bool> isProjectExist(String projectName,String workDir) {
    return _localDataSource.isProjectExist(projectName,workDir);
  }

  @override
  Future<bool> removeCodeRepo(String codeRepoName) {
    return _localDataSource.removeCodeRepo(codeRepoName);
  }
}
