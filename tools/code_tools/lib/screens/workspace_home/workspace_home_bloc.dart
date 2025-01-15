import 'dart:async';

import 'package:code_tools/domain/entities/workspace.dart';
import 'package:code_tools/domain/usecases/workspace_usecase.dart';
import 'package:code_tools/screens/home/home_screen.dart';
import 'package:code_tools/screens/workspace_home/workspace_home_event.dart';
import 'package:code_tools/screens/workspace_home/workspace_home_state.dart';
import 'package:code_tools/utils/ext_string.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_file_picker.dart';
import 'package:platform_utils/platform_utils.dart';

import '../../infra/db/database/code_tools_db.dart';

class WorkspaceHomeBloc
    extends BaseBloc<WorkSpaceHomeEvent, WorkspaceHomeState> {
  final WorkSpaceUseCase workSpaceUseCase;

  List<WorkSpaceEntity>? workspaces;

  WorkspaceHomeBloc({required this.workSpaceUseCase})
      : super(const WorkspaceHomeState()) {
    on<WorkSpaceHomeInitEvent>(_onInitHomeEvent);
    on<WorkSpaceCreateEvent>(_onCreateWorkSpaceEvent);
    on<WorkSpaceDeleteEvent>(_onDeleteWorkSpaceEvent);
    on<WorkSpaceClickEvent>(_onHomeClickWorkSpaceEvent);
  }

  FutureOr<void> _onInitHomeEvent(
      WorkSpaceHomeInitEvent event, Emitter<WorkspaceHomeState> emit) async {
    toastHelper.showLoading();
    workspaces = await workSpaceUseCase.loadAllWorkSpace();
    emit(state.copyWith(workspaces: workspaces ?? []));
    toastHelper.dismissLoading();
  }

  FutureOr<void> _onCreateWorkSpaceEvent(
      WorkSpaceCreateEvent event, Emitter<WorkspaceHomeState> emit) async {
    try {
      var dir = await FilePicker.platform.getDirectoryPath();
      if (dir == null || dir.isEmpty) {
        return;
      }
      dir = dir.adaptToMacFilePath;

      var dirName =
          await _showDirectoryNameDialog(navigatorKey.currentContext!);

      if (dirName.isEmpty) {
        return;
      }

      await workSpaceUseCase.createWorkSpace(
          workSpaceName: dirName, workSpaceDir: dir);

      // 重新加载所有的project
      add(WorkSpaceHomeInitEvent());
    } catch (e) {
      Logger.e(msg: 'pick file failed, $e');
      toastHelper.dismissLoading();
    }
  }

  FutureOr<void> _onHomeClickWorkSpaceEvent(
      WorkSpaceClickEvent event, Emitter<WorkspaceHomeState> emit) async {
    var firstWhere = workspaces?.firstWhere((e) {
      return e.workSpaceName == event.workSpaceEntity.workSpaceName;
    });

    if (firstWhere != null) {
      // 初始化DB

      // 初始化数据库
      await $FloorCodeToolsDatabase
          .databaseBuilder(
              '${firstWhere.workSpaceDir}/db/${firstWhere.workSpaceName}.db')
          .build()
          .then((onValue) {
        codeToolsDatabase = onValue;
      });

      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (BuildContext context) {
          return HomeScreen(
            workDir: firstWhere.workSpaceDir,
          );
        }),
      );
    }
  }

  FutureOr<void> _onDeleteWorkSpaceEvent(
      WorkSpaceDeleteEvent event, Emitter<WorkspaceHomeState> emit) async {
    final res = await workSpaceUseCase.removeWorkSpace(event.workSpaceEntity);
    if (res) {
      add(WorkSpaceHomeInitEvent());
    }
  }

  Future<String> _showDirectoryNameDialog(BuildContext context) async {
    String directoryName = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Directory Name'),
          content: TextField(
            onChanged: (value) {
              directoryName = value;
            },
            decoration: const InputDecoration(hintText: 'Directory Name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () {
                Navigator.of(context).pop();
                print('Directory Name: $directoryName');
                // 在这里可以添加创建目录的逻辑，例如使用 Directory 类
                // Directory dir = Directory(directoryName);
                // dir.create();
              },
            ),
          ],
        );
      },
    );
    return directoryName;
  }
}
