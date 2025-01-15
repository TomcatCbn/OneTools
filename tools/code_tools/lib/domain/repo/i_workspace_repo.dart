import 'package:code_tools/domain/entities/workspace.dart';

abstract class WorkSpaceRepo {
  Future<List<WorkSpaceEntity>> loadAllWorkSpace();

  Future<bool> addWorkSpace(WorkSpaceEntity workSpace);

  Future<bool> removeWorkSpace(String workSpaceName);
}
