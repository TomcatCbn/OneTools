import 'package:code_tools/infra/db/po/project_po.dart';
import 'package:platform_utils/platform_storage.dart';

@dao
abstract class ProjectDao {
  @Query('SELECT * FROM project')
  Future<List<ProjectPo>> findAllProject();

  @Query('SELECT * FROM project WHERE project_name = :projectName')
  Future<ProjectPo?> findProjectBy(String projectName);

  @insert
  Future<void> insertProject(ProjectPo project);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateProject(ProjectPo project);

  @delete
  Future<void> deleteProject(ProjectPo project);
}
