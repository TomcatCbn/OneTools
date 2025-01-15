import 'package:code_tools/infra/db/po/workspace_po.dart';
import 'package:platform_utils/platform_storage.dart';

@dao
abstract class WorkSpaceDao {
  @Query('SELECT * FROM workspace')
  Future<List<WorkSpacePo>> findAllWorkSpace();

  @Query('SELECT * FROM workspace WHERE workspace_name = :workSpaceName')
  Future<WorkSpacePo?> findCodeRepoBy(String workSpaceName);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWorkSpace(WorkSpacePo workSpace);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateWorkSpace(WorkSpacePo codeRepo);

  @Query('DELETE FROM workspace WHERE workspace_name = :workSpaceName')
  Future<void> deleteWorkSpaceBy(String workSpaceName);
}
