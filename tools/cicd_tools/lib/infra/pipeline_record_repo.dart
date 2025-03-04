import 'package:cicd_tools/domain/entities/cicd_pipeline.dart';
import 'package:cicd_tools/domain/repo/pipeline_record_repo.dart';

import 'datasource/pipeline_record_source.dart';

class PipelineRecordRepoImpl extends PipelineRecordRepo {
  PipelineRecordLocalDataSource dataSource = PipelineRecordLocalDataSource();

  @override
  Future<List<PipelineRecord>> loadLatestRecords({int latestNum = 20}) {
    return dataSource.loadLatestRecords(latestNum: latestNum);
  }

  @override
  Future<int> saveRecord(PipelineRecord record) {
    return dataSource.addPipelineRecord(record);
  }

  @override
  Future<void> updateRecord({required int id, DateTime? completedTime, PipelineStatus? status}) {
    return dataSource.updatePipelineRecord(
        completedTime: completedTime, status: status, id: id);
  }
}
