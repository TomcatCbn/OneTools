import 'dart:async';
import 'dart:io';

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

  PipelineHomeBloc({required this.workDir, required this.pipelineName})
      : super(const PipelineHomeState()) {
    on<PipelineInitEvent>(_onInitHomeEvent);
  }

  FutureOr<void> _onInitHomeEvent(
      PipelineInitEvent event, Emitter<PipelineHomeState> emit) async {
    // 加载所有的
  }
}
