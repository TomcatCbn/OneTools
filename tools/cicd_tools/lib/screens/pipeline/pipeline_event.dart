import 'package:cicd_tools/screens/pipeline/pipeline_state.dart';

sealed class PipelineHomeEvent {}

/// 初始化
class PipelineInitEvent extends PipelineHomeEvent {}

/// 创建pipeline
class PipelineStartEvent extends PipelineHomeEvent {}

/// 选择了module
class ModuleSelectEvent extends PipelineHomeEvent {
  final ModuleState? moduleState;

  ModuleSelectEvent({required this.moduleState});
}

/// module关键字变更
class ModuleKeyWordChangedEvent extends PipelineHomeEvent {
  final String keyWord;

  ModuleKeyWordChangedEvent({required this.keyWord});
}

/// 选择了module
class BranchSelectEvent extends PipelineHomeEvent {
  final String? branch;

  BranchSelectEvent({this.branch});
}