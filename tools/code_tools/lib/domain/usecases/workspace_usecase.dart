import 'dart:io';

import 'package:code_tools/domain/entities/project.dart';
import 'package:code_tools/domain/entities/workspace.dart';
import 'package:code_tools/domain/repo/i_workspace_repo.dart';

import '../factory/project_factory.dart';
import '../repo/i_project_repo.dart';

class WorkSpaceUseCase {
  final WorkSpaceRepo repo;

  WorkSpaceUseCase({required this.repo});

  Future<List<WorkSpaceEntity>> loadAllWorkSpace() async {
    return repo.loadAllWorkSpace();
  }

  Future<bool> createWorkSpace(
      {required String workSpaceName, required String workSpaceDir}) async {
    var directory = Directory('$workSpaceDir/$workSpaceName');
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    return repo.addWorkSpace(WorkSpaceEntity(workSpaceName, directory));
  }

  Future<bool> removeWorkSpace(WorkSpaceEntity entity) {
    var bool = repo.removeWorkSpace(entity.workSpaceName);
    // 自己手动删除目录
    return bool;
  }
}
