import 'dart:async';
import 'dart:io';

import 'package:cicd_tools/cicd_tools.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_event.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_state.dart';
import 'package:platform_utils/platform_utils.dart';

import '../../config/config_onesdk/module_repo_impl.dart';
import '../../domain/usecases/modules_release.dart';

class PipelineHomeBloc extends BaseBloc<PipelineHomeEvent, PipelineHomeState> {
  final Directory workDir;
  final String pipelineName;

  final ModuleReleaseUseCase _useCase =
      ModuleReleaseUseCase(repo: ModuleRepoImpl());

  final Map<String, ModuleEntity> _allModules = {};

  PipelineHomeBloc({required this.workDir, required this.pipelineName})
      : super(const PipelineHomeState()) {
    on<PipelineInitEvent>(_onInitHomeEvent);
    on<ModuleSelectEvent>(_onModuleSelectEvent);
    on<BranchSelectEvent>(_onBranchSelectEvent);
    on<PipelineStartEvent>(_onStartPipelineEvent);
  }

  FutureOr<void> _onInitHomeEvent(
      PipelineInitEvent event, Emitter<PipelineHomeState> emit) async {
    // 加载所有的
    _allModules.clear();
    var allModules = _useCase.loadAllModules();
    var list = allModules
        .map((e) => MapEntry(e.moduleName, e))
        .toList(growable: false);
    _allModules.addEntries(list);
    var moduleStates = allModules
        .map((e) => ModuleState(moduleName: e.moduleName))
        .toList(growable: false);
    emit(state.copyWith(modules: moduleStates));
  }

  FutureOr<void> _onModuleSelectEvent(
      ModuleSelectEvent event, Emitter<PipelineHomeState> emit) async {
    // 更新module，拉取branch
    var moduleName = event.moduleState?.moduleName;
    if (moduleName == null || moduleName.isEmpty) {
      toastHelper.showToast(msg: 'module信息为空');
      return;
    }

    var moduleEntity = _allModules[moduleName];
    if (moduleEntity == null) {
      toastHelper.showToast(msg: '配置中心未发现$moduleName');
      return;
    }

    var queryBranches =
        await moduleEntity.queryBranches(moduleEntity.repo.repoUrl);

    event.moduleState!.branches
      ..clear()
      ..addAll(queryBranches);

    emit(state.copyWith(selected: event.moduleState));
  }

  FutureOr<void> _onBranchSelectEvent(
      BranchSelectEvent event, Emitter<PipelineHomeState> emit) {}

  FutureOr<void> _onStartPipelineEvent(
      PipelineStartEvent event, Emitter<PipelineHomeState> emit) {}
}
