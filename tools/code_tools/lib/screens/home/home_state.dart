import 'package:platform_utils/platform_utils.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({@Default([]) List<ProjectState> projects}) =
      _HomeState;
}

@freezed
class ProjectState with _$ProjectState {
  const factory ProjectState({
    required String projectName,
    required String projectDesc,
    required String projectDir,
    @Default(0) int codeRepoCount,
  }) = _ProjectState;
}

