import 'dart:async';
import 'dart:io';

import 'package:code_tools/screens/code_repo_management/code_repo_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_file_picker.dart';
import 'package:platform_utils/platform_utils.dart';

import '../../domain/entities/project.dart';
import '../../domain/usecases/project_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final ProjectUseCase projectUseCase;
  final Directory workDir;

  List<ProjectAggregate>? projects;

  HomeBloc({required this.projectUseCase, required this.workDir})
      : super(const HomeState()) {
    on<HomeInitEvent>(_onInitHomeEvent);
    on<HomeCreateProjectByJsonFileEvent>(_onCreateProjectByJsonFileEvent);
    on<HomeClickProjectEvent>(_onHomeClickProjectEvent);
  }

  FutureOr<void> _onInitHomeEvent(
      HomeInitEvent event, Emitter<HomeState> emit) async {
    toastHelper.showLoading();
    var allProjects = await projectUseCase.loadAllProjects();
    projects = allProjects;
    toastHelper.dismissLoading();
    emit(state.copyWith(
        projects: allProjects
            .map((p) => ProjectState(
                projectName: p.projectName,
                projectDesc: p.projectDesc,
                projectDir: p.projectDir,
                codeRepoCount: p.codeRepos.length))
            .toList()));
  }

  FutureOr<void> _onCreateProjectByJsonFileEvent(
      HomeCreateProjectByJsonFileEvent event, Emitter<HomeState> emit) async {
    try {
      var filePickerResult = await FilePicker.platform.pickFiles(
          allowedExtensions: ['json'],
          allowMultiple: true,
          type: FileType.custom);
      if (filePickerResult == null) {
        return;
      }

      toastHelper.showLoading();

      for (final file in filePickerResult.xFiles) {
        var json = await file.readAsString();
        var project = projectUseCase.createProjectBy(json, workDir.path);
        await projectUseCase.addOrUpdateProject(project);
      }

      toastHelper.dismissLoading();
      // 重新加载所有的project
      add(HomeInitEvent());
    } catch (e) {
      Logger.e(msg: 'pick file failed, $e');
      toastHelper.dismissLoading();
    }
  }

  FutureOr<void> _onHomeClickProjectEvent(
      HomeClickProjectEvent event, Emitter<HomeState> emit) {
    var firstWhere = projects?.firstWhere((e) {
      return e.projectName == event.projectName;
    });

    if (firstWhere != null) {
      Navigator.push(
        event.context,
        MaterialPageRoute(builder: (BuildContext context) {
          return CodeRepoMgmtScreen(projectName: firstWhere.projectName);
        }),
      );
    }
  }
}
