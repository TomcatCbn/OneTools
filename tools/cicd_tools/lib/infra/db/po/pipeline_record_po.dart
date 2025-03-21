import 'package:cicd_tools/domain/entities/cicd_pipeline.dart';
import 'package:platform_utils/platform_storage.dart';

@Entity(tableName: 'pipeline_record', indices: [
  Index(value: ['pipeline_name', 'id'])
])
class PipelineRecordPo {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'pipeline_name')
  final String? pipelineName;

  @ColumnInfo(name: 'create_time')
  final int? createTime;

  @ColumnInfo(name: 'completed_time')
  final int? completedTime;

  @ColumnInfo(name: 'status')
  final String? status;

  @ColumnInfo(name: 'operator')
  final String? operator;

  @ColumnInfo(name: 'operation_log')
  final String? operationLog;

  // 用,分割
  @ColumnInfo(name: 'modules_name')
  final String? modulesName;

  PipelineRecordPo({
    this.id,
    this.pipelineName,
    this.createTime,
    this.status,
    this.completedTime,
    this.operator,
    this.operationLog,
    this.modulesName,
  });

  PipelineRecordPo.from(PipelineRecord record)
      : id = record.id == 0 ? null : record.id,
        pipelineName = record.pipelineName,
        createTime = record.createTime.millisecondsSinceEpoch,
        status = record.status.name,
        operator = record.operator,
        operationLog = record.operationLog,
        modulesName = record.modulesName.join(','),
        completedTime = record.completedTime?.millisecondsSinceEpoch ?? 0;

  PipelineRecord toDo() {
    var pipelineRecord = PipelineRecord(
      id: id ?? 0,
      pipelineName: pipelineName ?? '',
      createTime: DateTime.fromMillisecondsSinceEpoch(createTime ?? 0),
      operator: operator ?? 'unknown',
      operationLog: operationLog ?? '',
      modulesName: modulesName?.split(',') ?? [],
    );
    pipelineRecord.status = status?.toPipelineStatus() ?? PipelineStatus.idle;
    pipelineRecord.completedTime =
        DateTime.fromMillisecondsSinceEpoch(completedTime ?? 0);
    return pipelineRecord;
  }
}
