import 'package:code_tools/domain/entities/workspace.dart';
import 'package:platform_utils/platform_utils.dart';

part 'workspace_home_state.freezed.dart';

@freezed
class WorkspaceHomeState with _$WorkspaceHomeState {
  const factory WorkspaceHomeState({@Default([]) List<WorkSpaceEntity> workspaces}) =
      _WorkspaceHomeState;
}

