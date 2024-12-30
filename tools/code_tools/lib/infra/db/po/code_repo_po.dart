import 'package:platform_utils/platform_storage.dart';

import '../../../domain/entities/code_repo.dart';
import 'project_po.dart';

@Entity(tableName: 'code_repo', indices: [], foreignKeys: [
  ForeignKey(
    childColumns: ['project'],
    parentColumns: ['project_name'],
    entity: ProjectPo,
  )
])
class CodeRepoPo {
  @primaryKey
  @ColumnInfo(name: 'code_repo_name')
  final String codeRepoName;
  @ColumnInfo(name: 'repo_url')
  final String repoUrl;

  @ColumnInfo(name: 'work_dir')
  final String workDir;

  final String project;

  CodeRepoPo({
    required this.codeRepoName,
    required this.repoUrl,
    required this.workDir,
    required this.project,
  });

  CodeRepoEntity toDo() {
    return CodeRepoEntity(
        qualityEntity: QualityEntity.empty,
        gitEntity: GitEntity(gitRepo: repoUrl, repoDirName: codeRepoName),
        workDir: workDir,
        codeRepoName: codeRepoName);
  }
}
