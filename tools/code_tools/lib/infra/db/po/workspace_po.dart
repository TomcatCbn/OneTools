import 'package:platform_utils/platform_storage.dart';

// 工作空间
@Entity(tableName: 'workspace')
class WorkSpacePo {
  @primaryKey
  @ColumnInfo(name: 'workspace_name')
  final String workSpaceName;

  @ColumnInfo(name: 'workspace_dir')
  final String workSpaceDir;

  WorkSpacePo({
    required this.workSpaceName,
    required this.workSpaceDir,
  });
}
