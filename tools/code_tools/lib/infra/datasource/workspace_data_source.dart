import 'dart:io';

import 'package:code_tools/domain/entities/workspace.dart';
import 'package:code_tools/infra/db/dao/workspace_dao.dart';
import 'package:code_tools/infra/db/database/work_space_db.dart';
import 'package:code_tools/infra/db/po/workspace_po.dart';

class WorkSpaceLocalDataSource {
  final WorkSpaceDao workSpaceDao = workSpaceDatabase.workSpaceDao;

  WorkSpaceLocalDataSource();

  Future<List<WorkSpaceEntity>> loadWorkSpaces() async {
    List<WorkSpacePo> spaces = await workSpaceDao.findAllWorkSpace();
    return spaces.map((e) {
      return WorkSpaceEntity(e.workSpaceName, Directory(e.workSpaceDir));
    }).toList();
  }

  Future<bool> saveWorkSpace(WorkSpaceEntity workspace) async {
    await workSpaceDao.insertWorkSpace(WorkSpacePo(
        workSpaceName: workspace.workSpaceName,
        workSpaceDir: workspace.workSpaceDir.path));
    return true;
  }

  Future<bool> removeWorkSpace(String workSpaceName) async {
    await workSpaceDao.deleteWorkSpaceBy(workSpaceName);
    return true;
  }
}
