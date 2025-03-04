import 'package:cicd_tools/domain/entities/cicd_pipeline.dart';
import 'package:platform_utils/platform_utils.dart';

part 'pipeline_state.freezed.dart';

@freezed
class PipelineHomeState with _$PipelineHomeState {
  const factory PipelineHomeState({
    Pipeline? pipeline,
    @Default([]) List<ModuleState> modules,
    // 当前默认选中的module
    ModuleState? selected,
    @Default(0) int refreshIndex,
    @Default(BtnState.disable) BtnState pipelineBtnState,
  }) = _PipelineHomeState;
}

class ModuleState {
  final String moduleName;
  List<String> branches = [];

  String selectBranch = '';

  ModuleState({required this.moduleName});
}

enum BtnState {
  enable,
  inProgress,
  disable,
}
