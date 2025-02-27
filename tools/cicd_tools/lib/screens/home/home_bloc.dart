import 'dart:async';
import 'dart:io';

import 'package:cicd_tools/screens/pipeline/pipeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_utils.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final Directory workDir;

  HomeBloc({required this.workDir}) : super(const HomeState()) {
    on<HomeInitEvent>(_onInitHomeEvent);
    on<HomeClickPipelineEvent>(_onHomeClickPipelineEvent);
  }

  FutureOr<void> _onInitHomeEvent(
      HomeInitEvent event, Emitter<HomeState> emit) async {
    toastHelper.showLoading();

    PipelineState applicationAndroidP = PipelineState(name: 'Android应用发布');
    PipelineState applicationIOSP = PipelineState(name: 'iOS应用发布');
    PipelineState publishAndroidModule =
        PipelineState(name: 'Android Module 发布');
    PipelineState publishIOSModule = PipelineState(name: 'iOS Module 发布');
    PipelineState checkIOSModule = PipelineState(name: 'Check Android Module');
    PipelineState checkAndroidModule = PipelineState(name: 'Check iOS Module');
    PipelineState repoMerge = PipelineState(name: '仓库分支Merge');

    List<PipelineState> list = [];
    list.add(applicationAndroidP);
    list.add(applicationIOSP);
    list.add(publishAndroidModule);
    list.add(publishIOSModule);
    list.add(checkIOSModule);
    list.add(checkIOSModule);
    list.add(checkAndroidModule);
    list.add(repoMerge);

    emit(state.copyWith(pipelines: list));
    toastHelper.dismissLoading();
  }

  FutureOr<void> _onHomeClickPipelineEvent(
      HomeClickPipelineEvent event, Emitter<HomeState> emit) {
    var pipeline = state.pipelines[event.index];

    Navigator.push(
      event.context,
      MaterialPageRoute(builder: (BuildContext context) {
        return PipelineHomeScreen(
          workDir: workDir,
          pipelineName: pipeline.name,
        );
      }),
    );
  }
}
