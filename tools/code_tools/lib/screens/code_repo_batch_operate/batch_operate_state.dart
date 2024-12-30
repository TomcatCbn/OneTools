import 'package:platform_utils/platform_utils.dart';

part 'batch_operate_state.freezed.dart';

@freezed
class BatchOperateState with _$BatchOperateState {
  const factory BatchOperateState({
    @Default([]) List<CodeRepoState> codeRepos,
    @Default(0) int refreshIndex,
  }) = _BatchOperateState;
}

class CodeRepoState {
  final String codeRepoName;
  bool isSelect;

  CodeRepoState({required this.codeRepoName, this.isSelect = false});

  @override
  String toString() {
    return 'CodeRepoState{codeRepoName: $codeRepoName, isSelect: $isSelect}';
  }
}
