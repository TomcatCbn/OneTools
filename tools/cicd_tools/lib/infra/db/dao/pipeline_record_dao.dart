import 'package:cicd_tools/infra/db/po/pipeline_record_po.dart';
import 'package:platform_utils/platform_storage.dart';

@dao
abstract class PipelineRecordDao {
  @Query('SELECT * FROM pipeline_record ORDER BY id DESC LIMIT :latestNum')
  Future<List<PipelineRecordPo>> loadLatestRecords(int latestNum);

  @insert
  Future<int> insertProject(PipelineRecordPo record);

  @Query('SELECT * FROM pipeline_record WHERE id = :id')
  Future<PipelineRecordPo?> findRecordBy(int id);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateRecord(PipelineRecordPo record);
}
