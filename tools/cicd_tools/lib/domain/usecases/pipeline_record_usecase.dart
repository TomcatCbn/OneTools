import 'package:cicd_tools/domain/entities/cicd_pipeline.dart';
import 'package:cicd_tools/domain/repo/pipeline_record_repo.dart';
import 'package:cicd_tools/infra/pipeline_record_repo.dart';

class PipelineRecordsUseCase {
  final PipelineRecordRepo repo = PipelineRecordRepoImpl();

  PipelineRecordsUseCase();

  Future<List<PipelineRecord>> loadLatestRecords({int latestNum = 20}) {
    return repo.loadLatestRecords(latestNum: latestNum);
  }

}