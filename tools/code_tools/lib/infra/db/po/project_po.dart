import 'package:platform_utils/platform_storage.dart';

@Entity(tableName: 'project', indices: [
  Index(value: ['project_name'])
])
class ProjectPo {
  @primaryKey
  @ColumnInfo(name: 'project_name')
  final String projectName;

  @ColumnInfo(name: 'project_desc')
  final String projectDesc;

  @ColumnInfo(name: 'work_dir')
  final String workDir;

  ProjectPo({
    required this.projectName,
    required this.projectDesc,
    required this.workDir,
  });
}
