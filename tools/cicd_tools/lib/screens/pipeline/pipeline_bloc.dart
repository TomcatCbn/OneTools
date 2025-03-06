import 'dart:async';
import 'dart:io';

import 'package:cicd_tools/cicd_tools.dart';
import 'package:cicd_tools/config/config_onesdk/environment_config_impl.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_event.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_state.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_utils.dart';

import '../../config/config_onesdk/module_repo_impl.dart';
import '../../domain/entities/cicd_pipeline.dart';
import '../../domain/usecases/pipeline_usecase.dart';

class PipelineHomeBloc extends BaseBloc<PipelineHomeEvent, PipelineHomeState> {
  final Directory workDir;
  final String pipelineName;
  final PipelineType pipelineType;

  final PipelineUseCase _useCase;

  final Map<String, ModuleEntity> _allModules = {};

  final TextEditingController filterController = TextEditingController();

  PipelineHomeBloc({
    required this.workDir,
    required this.pipelineName,
    required this.pipelineType,
  })  : _useCase =
            PipelineUseCase(repo: ModuleRepoImpl(), pipelineName: pipelineName),
        super(const PipelineHomeState()) {
    on<PipelineInitEvent>(_onInitHomeEvent);
    on<ModuleSelectEvent>(_onModuleSelectEvent);
    on<BranchSelectEvent>(_onBranchSelectEvent);
    on<PipelineStartEvent>(_onStartPipelineEvent);
    on<ModuleKeyWordChangedEvent>(_onModuleKeyWordChanged);
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
    String filter = '';
    switch (pipelineType) {
      case PipelineType.aar:
      case PipelineType.apk:
      case PipelineType.androidCheckModule:
        filter = 'android';
        break;
      case PipelineType.pod:
      case PipelineType.ipa:
      case PipelineType.iosCheckModule:
        filter = 'ios';
        break;
    }

    moduleStates = moduleStates
        .where((e) => e.moduleName.startsWith(filter))
        .toList(growable: false);
    filterController.text = filter;
    emit(state.copyWith(modules: moduleStates));
  }

  FutureOr<void> _onModuleSelectEvent(
      ModuleSelectEvent event, Emitter<PipelineHomeState> emit) async {
    Logger.i(msg: '_onModuleSelectEvent...${event.moduleState}');
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
    var branches = queryBranches.fold(
        ifLeft: (e) {
          toastHelper.showToast(msg: e.msg);
          return <String>[];
        },
        ifRight: (v) => v);

    event.moduleState!.branches
      ..clear()
      ..addAll(branches);
    event.moduleState!.selectBranch = branches.first;

    emit(state.copyWith(
        selected: event.moduleState, pipelineBtnState: BtnState.enable));
  }

  FutureOr<void> _onBranchSelectEvent(
      BranchSelectEvent event, Emitter<PipelineHomeState> emit) async {
    Logger.i(msg: '_onBranchSelectEvent..., ${event.branch}');
    var selected = state.selected;
    if (selected == null) {
      return;
    }
    selected.selectBranch = event.branch ?? '';

    emit(state.copyWith(refreshIndex: state.refreshIndex + 1));
  }

  FutureOr<void> _onStartPipelineEvent(
      PipelineStartEvent event, Emitter<PipelineHomeState> emit) async {
    Logger.i(msg: '_onStartPipelineEvent...');
    var selected = state.selected;
    if (selected == null || selected.selectBranch.isEmpty) {
      toastHelper.showToast(msg: '参数不正确');
      return;
    }
    var module = _allModules[selected.moduleName];
    if (module == null) {
      toastHelper.showToast(msg: '参数不正确');
      return;
    }

    var pipeline = await _useCase.createPipeline(pipelineType.name, module,
        branch: selected.selectBranch, env: EnvironmentImpl());
    if (pipeline == null) {
      toastHelper.showToast(msg: '创建pipeline失败');
      return;
    }
    emit(state.copyWith(pipelineBtnState: BtnState.inProgress));
    // 开始监听pipeline事件
    pipeline.pipelineEvent.listen((onData) {
      if (onData is StageChangedEvent) {
        if (pipeline.pipelineStatus == PipelineStatus.running) {
          toastHelper.showLoading(msg: 'Running ${onData.stage.nameId}...');
        }
      }
    });

    var either = await pipeline.run({});
    toastHelper.dismissLoading();
    either.fold(ifLeft: (e) {
      toastHelper.showToast(msg: 'pipeline运行失败');
    }, ifRight: (v) {
      toastHelper.showToast(msg: 'pipeline运行成功');
    });
    _useCase.release();
    Navigator.pop(navigatorKey.currentContext!);
  }

  FutureOr<void> _onModuleKeyWordChanged(
      ModuleKeyWordChangedEvent event, Emitter<PipelineHomeState> emit) async {
    Logger.i(msg: 'ModuleKeyWordChangedEvent..., ${event.keyWord}');
    var moduleStates = _allModules.values
        .map((e) => ModuleState(moduleName: e.moduleName))
        .toList(growable: false);

    if (event.keyWord.isEmpty) {
      emit(state.copyWith(modules: moduleStates));
      return;
    }

    var list = moduleStates
        .where((t) => t.moduleName.contains(event.keyWord))
        .toList(growable: false);
    emit(state.copyWith(modules: list));
  }
}
