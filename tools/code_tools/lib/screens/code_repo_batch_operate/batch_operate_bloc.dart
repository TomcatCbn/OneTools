import 'dart:async';

import 'package:code_tools/domain/entities/code_repo.dart';
import 'package:code_tools/screens/code_repo_batch_operate/batch_operate_event.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_utils.dart';

import 'batch_operate_state.dart';

class BatchOperateBloc extends BaseBloc<BatchOperateEvent, BatchOperateState> {
  final List<CodeRepoEntity> codeRepoEntities;

  // 用于筛选框
  final TextEditingController filtercontroller = TextEditingController();
  // 用于输入目标名称框
  final TextEditingController targetNameController = TextEditingController();

  // backup
  final List<CodeRepoState> _codeRepoList = [];

  BatchOperateBloc({required this.codeRepoEntities})
      : super(const BatchOperateState()) {
    on<BatchOperateInitEvent>(_onBatchOperateInitEvent);
    on<BatchOperateSelectEvent>(_onBatchOperateSelectEvent);
    // TODO: debounce
    on<BatchOperateSearchKeyWordEvent>(_onSearchKeyWordEvent);
    on<BatchOperateConfirmEvent>(_onBatchOperateConfirmEvent);
    on<BatchOperateSelectBranchEvent>(_onBatchOperateSelectBranchEvent);
    on<BatchOperateCreateBranchEvent>(_onBatchOperateCreateBranchEvent);
    on<BatchOperateCreateTagEvent>(_onBatchOperateCreateTagEvent);
  }

  FutureOr<void> _onBatchOperateInitEvent(
      BatchOperateInitEvent event, Emitter<BatchOperateState> emit) {
    var list = codeRepoEntities
        .map((e) => CodeRepoState(
            codeRepoName: e.codeRepoName, branches: e.gitEntity.allBranches))
        .toList();
    _codeRepoList.addAll(list);
    // 默认用第一个仓库的branch
    emit(state.copyWith(
        codeRepos: list,
        branchesForSelect: list.first.branches,
        targetName: ''));
  }

  FutureOr<void> _onBatchOperateSelectEvent(
      BatchOperateSelectEvent event, Emitter<BatchOperateState> emit) {
    var indexWhere =
        state.codeRepos.indexWhere((e) => e.codeRepoName == event.codeRepoName);
    var codeRepo = state.codeRepos[indexWhere];
    codeRepo.isSelect = !codeRepo.isSelect;
    emit(state.copyWith(
        refreshIndex: state.refreshIndex + 1,
        branchesForSelect: codeRepo.branches));
  }

  FutureOr<void> _onSearchKeyWordEvent(BatchOperateSearchKeyWordEvent event,
      Emitter<BatchOperateState> emit) async {
    if (event.keyWord.isEmpty) {
      // 还原
      emit(state.copyWith(codeRepos: _codeRepoList));
      return;
    }

    // 确保操作的是同一个实例
    List<CodeRepoState> listTemp = [..._codeRepoList];
    var res =
        listTemp.where((e) => e.codeRepoName.contains(event.keyWord)).toList();
    emit(state.copyWith(codeRepos: res));
  }

  FutureOr<void> _onBatchOperateConfirmEvent(
      BatchOperateConfirmEvent event, Emitter<BatchOperateState> emit) {
    var list = _codeRepoList
        .where((e) => e.isSelect)
        .map((e) => e.codeRepoName)
        .toList();
    Logger.i(msg: 'BatchOperateConfirmEvent, $list');
    navigatorKey.currentState?.pop(
        BatchOperateRsp(codeRepos: list, targetName: state.targetName));
  }

  FutureOr<void> _onBatchOperateSelectBranchEvent(
      BatchOperateSelectBranchEvent event, Emitter<BatchOperateState> emit) {
    emit(state.copyWith(targetName: event.branchName));
  }

  FutureOr<void> _onBatchOperateCreateBranchEvent(
      BatchOperateCreateBranchEvent event, Emitter<BatchOperateState> emit) {
    emit(state.copyWith(targetName: event.branchName));
  }

  FutureOr<void> _onBatchOperateCreateTagEvent(
      BatchOperateCreateTagEvent event, Emitter<BatchOperateState> emit) {
    emit(state.copyWith(targetName: event.tagName));
  }
}
