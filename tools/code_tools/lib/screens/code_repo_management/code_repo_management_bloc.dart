import 'dart:async';

import 'package:code_tools/domain/entities/project.dart';
import 'package:code_tools/domain/usecases/project_usecase.dart';
import 'package:code_tools/screens/code_repo_management/code_repo_management_event.dart';
import 'package:code_tools/screens/code_repo_management/code_repo_management_state.dart';
import 'package:platform_plugins/platform_plugins.dart';
import 'package:platform_utils/platform_utils.dart';

class CodeRepoMgmtBloc extends BaseBloc<CodeRepoMgmtEvent, CodeRepoMgmtState> {
  static const String _tag = 'CodeRepoBloc';
  final String projectName;
  final ProjectUseCase projectUseCase;

  late ProjectAggregate projectAggregate;

  CodeRepoMgmtBloc({required this.projectName, required this.projectUseCase})
      : super(const CodeRepoMgmtState()) {
    on<CodeRepoMgmtInitEvent>(_onCodeRepoInitEvent);
    on<CodeRepoOperationEvent>(_onCodeRepoOperationEvent);
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
    await projectAggregate.config();
    emit(state.copyWith(codeRepoEntities: projectAggregate.codeRepos));
  }

  FutureOr<void> _onCodeRepoOperationEvent(
      CodeRepoOperationEvent event, Emitter<CodeRepoMgmtState> emit) {
    Logger.i(msg: 'CodeRepoOperationEvent...${event.operation}', tag: _tag);

    toastHelper.showToast(msg: event.operation);
  }
}
