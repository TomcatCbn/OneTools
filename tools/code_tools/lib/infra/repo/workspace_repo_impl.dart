import 'package:code_tools/domain/entities/workspace.dart';
import 'package:code_tools/domain/repo/i_workspace_repo.dart';
import 'package:code_tools/infra/datasource/workspace_data_source.dart';

class WorkspaceRepoImpl implements WorkSpaceRepo {
  final WorkSpaceLocalDataSource _localDataSource;

  WorkspaceRepoImpl({required WorkSpaceLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<bool> addWorkSpace(WorkSpaceEntity workSpace) {
    return _localDataSource.saveWorkSpace(workSpace);
  }

  @override
  Future<List<WorkSpaceEntity>> loadAllWorkSpace() {
    return _localDataSource.loadWorkSpaces();
  }

  @override
  Future<bool> removeWorkSpace(String workSpaceName) {
    return _localDataSource.removeWorkSpace(workSpaceName);
  }
}
