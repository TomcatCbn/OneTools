import 'package:cicd_tools/domain/entities/cicd_pipeline.dart';

abstract class PipelineRecordRepo {
  /// 获取最近的[latestNum]个记录
  Future<List<PipelineRecord>> loadLatestRecords({int latestNum = 20});

  Future<int> saveRecord(PipelineRecord record);

  Future<void> updateRecord(
      {required int id, DateTime? completedTime, PipelineStatus? status});
}
