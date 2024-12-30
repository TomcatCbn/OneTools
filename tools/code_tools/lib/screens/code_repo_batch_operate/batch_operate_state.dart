import 'package:platform_utils/platform_utils.dart';

part 'batch_operate_state.freezed.dart';

@freezed
class BatchOperateState with _$BatchOperateState {
  const factory BatchOperateState({
    @Default([]) List<CodeRepoState> codeRepos,
    @Default([]) List<String> branchesForSelect,
    String? selectedBranch,
    @Default(0) int refreshIndex,
  }) = _BatchOperateState;
}

class CodeRepoState {
  final String codeRepoName;
  List<String> branches;
  bool isSelect;

  CodeRepoState({
    required this.codeRepoName,
    this.isSelect = false,
    this.branches = const [],
  });

  @override
  String toString() {
    return 'CodeRepoState{codeRepoName: $codeRepoName, isSelect: $isSelect}';
  }
}

class BatchOperateRsp {
  final List<String> codeRepos;
  String? branchName;

  BatchOperateRsp({required this.codeRepos, this.branchName});
}
