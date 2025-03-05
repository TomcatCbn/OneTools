import 'package:cicd_tools/domain/entities/cicd_pipeline.dart';
import 'package:cicd_tools/infra/db/dao/pipeline_record_dao.dart';
import 'package:cicd_tools/infra/db/database/cicd_tools_db.dart';
import 'package:cicd_tools/infra/db/po/pipeline_record_po.dart';

class PipelineRecordLocalDataSource {
  final PipelineRecordDao recordDao = cicdToolsDatabase.recordDao;

  PipelineRecordLocalDataSource();

  Future<int> addPipelineRecord(PipelineRecord record) async {
    var i = await recordDao.insertProject(PipelineRecordPo.from(record));
    record.id = i;
    return i;
  }

  Future<List<PipelineRecord>> loadLatestRecords(
      {required int latestNum}) async {
    var loadLatestRecords = await recordDao.loadLatestRecords(latestNum);
    return loadLatestRecords.map((e) => e.toDo()).toList(growable: false);
  }

  Future<bool> updatePipelineRecord(
      {required int id,
      DateTime? completedTime,
      PipelineStatus? status}) async {
    var findRecordBy = await recordDao.findRecordBy(id);
    if (findRecordBy == null) {
      return false;
    }

    recordDao.updateRecord(PipelineRecordPo(
      id: id,
      pipelineName: findRecordBy.pipelineName,
      createTime: findRecordBy.createTime,
      status: status?.name,
      completedTime: completedTime?.millisecondsSinceEpoch,
      operator: findRecordBy.operator,
      operationLog: findRecordBy.operationLog,
      modulesName: findRecordBy.modulesName,
    ));
    return true;
  }
}
