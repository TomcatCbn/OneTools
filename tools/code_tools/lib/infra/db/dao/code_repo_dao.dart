import 'package:code_tools/infra/db/po/code_repo_po.dart';
import 'package:platform_utils/platform_storage.dart';

@dao
abstract class CodeRepoDao {
  @Query('SELECT * FROM code_repo')
  Future<List<CodeRepoPo>> findAllCodeRepo();

  @Query('SELECT * FROM code_repo WHERE repo_url = :repoUrl')
  Future<CodeRepoPo?> findCodeRepoBy(String repoUrl);

  @Query('SELECT * FROM code_repo WHERE project = :project')
  Future<List<CodeRepoPo>> findAllCodeRepoBy(String project);

  @insert
  Future<void> insertCodeRepo(CodeRepoPo codeRepo);

  @insert
  Future<void> insertCodeRepos(List<CodeRepoPo> codeRepos);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCodeRepo(CodeRepoPo codeRepo);

  @delete
  Future<void> deleteCodeRepo(CodeRepoPo codeRepo);
}
