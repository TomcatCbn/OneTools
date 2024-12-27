import 'package:platform_utils/platform_utils.dart';

part 'code_repo_management_state.freezed.dart';

@freezed
class CodeRepoMgmtState with _$CodeRepoMgmtState {
  const factory CodeRepoMgmtState({
    @Default([]) List<CodeRepoState> codeRepos,
    @Default(0) int refresh,
  }) = _CodeRepoMgmtState;
}

@freezed
class CodeRepoState with _$CodeRepoState {
  const factory CodeRepoState({
    required String repoName,
    @Default('unknown') String branch,
  }) = _CodeRepoState;
}
