import 'dart:async';

import 'package:code_tools/domain/entities/project.dart';
import 'package:code_tools/domain/usecases/project_usecase.dart';
import 'package:code_tools/screens/code_repo_management/code_repo_management_event.dart';
import 'package:code_tools/screens/code_repo_management/code_repo_management_state.dart';
import 'package:code_tools/utils/settings_utils.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_utils.dart';

import '../../domain/entities/git_action.dart';
import '../code_repo_batch_operate/batch_operate_screen.dart';
import '../code_repo_batch_operate/batch_operate_state.dart';

class CodeRepoMgmtBloc extends BaseBloc<CodeRepoMgmtEvent, CodeRepoMgmtState> {
  static const String _tag = 'CodeRepoBloc';
  final String projectName;
  final ProjectUseCase projectUseCase;

  late ProjectAggregate projectAggregate;

  CodeRepoMgmtBloc(
      {required this.projectName,
      required this.projectUseCase})
      : super(const CodeRepoMgmtState()) {
    on<CodeRepoMgmtInitEvent>(_onCodeRepoInitEvent);
    on<CodeRepoOperationEvent>(_onCodeRepoOperationEvent);
    on<CodeRepoDeleteEvent>(_onCodeRepoDeleteEvent);
  }

  FutureOr<void> _onCodeRepoInitEvent(
      CodeRepoMgmtInitEvent event, Emitter<CodeRepoMgmtState> emit) async {
    Logger.i(msg: 'CodeRepoInitEvent...', tag: _tag);

    final t = await projectUseCase.loadProjectBy(projectName);
    if (t == null) {
      toastHelper.showToast(msg: '找不到$projectName');
      navigatorKey.currentState?.pop();
      return;
    }

    projectAggregate = t;
    // 检测code repo各个状态
    await projectAggregate.config(
        useProxy: PlatformSettingBox().getBool(proxyKey),
        proxyValue: PlatformSettingBox().getString(proxyValueKey));
    emit(state.copyWith(codeRepoEntities: projectAggregate.codeRepos));
  }

  FutureOr<void> _onCodeRepoOperationEvent(
      CodeRepoOperationEvent event, Emitter<CodeRepoMgmtState> emit) async {
    Logger.i(msg: 'CodeRepoOperationEvent...${event.operation}', tag: _tag);

    BatchOperateRsp? rsp = await Navigator.push(
        event.context,
        MaterialPageRoute(
            builder: (context) => BatchOperateScreen(
                  operation: event.operation,
                  codeRepoEntities: projectAggregate.codeRepos,
                )));

    if (rsp != null) {
      await Future.delayed(const Duration(milliseconds: 500));
      _doOperation(rsp.codeRepos, event.operation, targetName: rsp.targetName);
    }
  }

  FutureOr<void> _onCodeRepoDeleteEvent(
      CodeRepoDeleteEvent event, Emitter<CodeRepoMgmtState> emit) async {
    Logger.i(msg: 'CodeRepoDeleteEvent...${event.codeRepoName}', tag: _tag);

    await projectUseCase.deleteCodeRepo(projectAggregate, event.codeRepoName);

    add(CodeRepoMgmtInitEvent());
  }

  void _doOperation(List<String> selectedRepos, CodeRepoOperation operation,
      {String? targetName}) {
    if (selectedRepos.isEmpty) {
      return;
    }
    var codeRepos = projectAggregate.codeRepos;
    var toBeOperate = selectedRepos.map((e1) {
      return codeRepos.firstWhere((e2) => e2.codeRepoName == e1);
    }).toList();
    switch (operation) {
      case CodeRepoOperation.checkout:
        for (var e in toBeOperate) {
          e.execGitCMD(operation, branchName: targetName);
        }
        break;
      case CodeRepoOperation.pull:
        for (var e in toBeOperate) {
          e.execGitCMD(operation);
        }
        break;
      case CodeRepoOperation.tag:
        for (var e in toBeOperate) {
          e.execGitCMD(operation, tagName: targetName);
        }
        break;
      case CodeRepoOperation.branch:
        for (var e in toBeOperate) {
          e.execGitCMD(operation, branchName: targetName);
        }
        break;
      case CodeRepoOperation.publish:
        break;
      case CodeRepoOperation.codeStatistic:
      // TODO: Handle this case.
      case CodeRepoOperation.repoDependencies:
      // TODO: Handle this case.
    }
  }
}
