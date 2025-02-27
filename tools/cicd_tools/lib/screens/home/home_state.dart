import 'package:platform_utils/platform_utils.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({@Default([]) List<PipelineState> pipelines}) =
      _HomeState;
}

class PipelineState {
  final String name;

  PipelineState({required this.name});
}
