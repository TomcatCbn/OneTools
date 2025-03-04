import 'package:platform_utils/platform_utils.dart';

import '../../domain/entities/cicd_pipeline.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<PipelineState> pipelines,
    @Default([]) List<PipelineRecord> records,
  }) = _HomeState;
}

class PipelineState {
  final String name;
  final PipelineType pipelineType;

  PipelineState({required this.name, required this.pipelineType});
}
