import 'package:platform_utils/platform_utils.dart';

import '../../domain/entities/code_repo.dart';

part 'code_repo_management_state.freezed.dart';

@freezed
class CodeRepoMgmtState with _$CodeRepoMgmtState {
  const factory CodeRepoMgmtState({
    @Default([]) List<CodeRepoEntity> codeRepoEntities,
    @Default(0) int refresh,
  }) = _CodeRepoMgmtState;
}
