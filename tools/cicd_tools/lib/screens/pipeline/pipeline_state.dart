import 'package:cicd_tools/domain/entities/cicd_pipeline.dart';
import 'package:platform_utils/platform_utils.dart';

part 'pipeline_state.freezed.dart';

@freezed
class PipelineHomeState with _$PipelineHomeState {
  const factory PipelineHomeState({Pipeline? pipeline}) =
      _PipelineHomeState;
}

