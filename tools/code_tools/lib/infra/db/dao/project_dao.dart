import 'package:code_tools/infra/db/po/project_po.dart';
import 'package:platform_utils/platform_storage.dart';

@dao
abstract class ProjectDao {
  @Query('SELECT * FROM project WHERE work_dir = :workDir')
  Future<List<ProjectPo>> findAllProject(String workDir);

  @Query('SELECT * FROM project WHERE project_name = :projectName AND work_dir = :workDir')
  Future<ProjectPo?> findProjectBy(String projectName, String workDir);

  @insert
  Future<void> insertProject(ProjectPo project);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateProject(ProjectPo project);

  @delete
  Future<void> deleteProject(ProjectPo project);
}
