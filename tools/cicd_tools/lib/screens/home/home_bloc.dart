import 'dart:async';
import 'dart:io';

import 'package:cicd_tools/domain/entities/cicd_pipeline.dart';
import 'package:cicd_tools/domain/usecases/pipeline_record_usecase.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_screen.dart';
import 'package:cicd_tools/screens/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_utils.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final Directory workDir;
  final PipelineRecordsUseCase _useCase = PipelineRecordsUseCase();

  HomeBloc({required this.workDir}) : super(const HomeState()) {
    on<HomeInitEvent>(_onInitHomeEvent);
    on<HomeClickPipelineEvent>(_onHomeClickPipelineEvent);
  }

  FutureOr<void> _onInitHomeEvent(
      HomeInitEvent event, Emitter<HomeState> emit) async {
    toastHelper.showLoading();

    PipelineState applicationAndroidP =
        PipelineState(name: 'Android应用发布', pipelineType: PipelineType.apk);
    PipelineState applicationIOSP =
        PipelineState(name: 'iOS应用发布', pipelineType: PipelineType.ipa);
    PipelineState publishAndroidModule = PipelineState(
        name: 'Android Module 发布', pipelineType: PipelineType.aar);
    PipelineState publishIOSModule =
        PipelineState(name: 'iOS Module 发布', pipelineType: PipelineType.pod);
    PipelineState checkAndroidModule = PipelineState(
        name: 'Check Android Module',
        pipelineType: PipelineType.androidCheckModule);
    PipelineState checkIOSModule = PipelineState(
        name: 'Check iOS Module', pipelineType: PipelineType.iosCheckModule);
    // PipelineState repoMerge = PipelineState(name: '仓库分支Merge');

    List<PipelineState> list = [];
    list.add(applicationAndroidP);
    list.add(applicationIOSP);
    list.add(publishAndroidModule);
    list.add(publishIOSModule);
    list.add(checkIOSModule);
    list.add(checkAndroidModule);
    // list.add(repoMerge);

    // 刷新record列表
    var records = await _useCase.loadLatestRecords();

    emit(state.copyWith(pipelines: list, records: records));
    toastHelper.dismissLoading();
  }

  FutureOr<void> _onHomeClickPipelineEvent(
      HomeClickPipelineEvent event, Emitter<HomeState> emit) async {
    var pipeline = state.pipelines[event.index];
    // 检查操作员
    var bool = await showUserInfoDialog(event.context);
    if (!bool) {
      toastHelper.showToast(msg: '请核对账号');
      return;
    }

    await Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (BuildContext context) {
        return PipelineHomeScreen(
          workDir: workDir,
          pipelineName: pipeline.name,
          pipelineType: pipeline.pipelineType,
        );
      }),
    );

    // 刷新record列表
    // 延迟一段时间，保证record数据已经更新
    await Future.delayed(const Duration(seconds: 1));
    var list = await _useCase.loadLatestRecords();
    emit(state.copyWith(records: list));
  }

  Future<bool> showUserInfoDialog(BuildContext context) async {
    bool? res = await showDialog(
        context: context, builder: (context) => const LoginDialog());
    return res ?? false;
  }
}
