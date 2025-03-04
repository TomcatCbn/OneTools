import 'package:cicd_tools/cicd_tools.dart';
import 'package:cicd_tools/domain/entities/cicd_stage.dart';
import 'package:cicd_tools/domain/entities/stage_config.dart';
import 'package:cicd_tools/domain/repo/pipeline_record_repo.dart';
import 'package:cicd_tools/domain/services/operator_service.dart';
import 'package:cicd_tools/infra/pipeline_record_repo.dart';
import 'package:platform_utils/platform_stream_enhance.dart' as streamen;
import 'package:platform_utils/platform_utils.dart';

import '../../plugin/cicd_tools_plugins.dart';
import '../entities/cicd_pipeline.dart';

class PipelineUseCase {
  final ModuleRepo repo;
  final String pipelineName;
  final PipelineRecordRepo pipelineRecordRepo = PipelineRecordRepoImpl();

  PipelineUseCase({required this.repo, required this.pipelineName}) {
    // 开启单独的日志，方便回溯
    var timestamp = formatDate(
        DateTime.now(), [yyyy, '-', mm, '-', dd, '-', HH, '-', nn, '-', ss]);
    String fileName = '${OperatorService().curr?.name}-$timestamp.log';
    String filePath = '${CICDTools().workDirName}/logs/$pipelineName/$fileName';
    Logger.logToNewFile(filePath: filePath);
  }

  void release() {
    // 关闭file log
    Future.delayed(const Duration(seconds: 3)).then((onValue) {
      Logger.closeFileWrite();
    });
  }

  Pipeline? createPipeline(String pipelineType, ModuleEntity entity,
      {required String branch, Environment? env}) {
    Logger.i(
        msg:
            'createPipeline, $pipelineName, $pipelineType, ${entity.moduleName}, $branch');
    // 设置目标分支
    entity.targetBranch = branch;
    Pipeline? pipeline;
    switch (pipelineType.toPipelineType()) {
      case PipelineType.aar:
        pipeline = _doCreateAndroidModulePipeline(entity, env);
        break;
      case PipelineType.pod:
        pipeline = _doCreateIOSModulePipeline(entity, env);
        break;
      case PipelineType.apk:
        pipeline = _doCreateAndroidApkPipeline(entity, env);
        break;
      case PipelineType.ipa:
      // TODO: Handle this case.
      case PipelineType.androidCheckModule:
      // TODO: Handle this case.
      case PipelineType.iosCheckModule:
        // TODO: Handle this case.
        break;
    }

    if (pipeline != null) {
      final p = pipeline;
      // save in db
      var pipelineRecord = PipelineRecord(
          pipelineName: pipelineName,
          createTime: DateTime.now(),
          operator: OperatorService().curr?.name ?? 'unknown');
      pipelineRecordRepo.saveRecord(pipelineRecord).then((onValue) {
        p.id = onValue;
      });

      // 监听

      streamen.Where(pipeline.pipelineEvent)
          .whereType<PipelineStatusChangedEvent>()
          .listen((event) {
        Logger.i(msg: 'receive PipelineStatusChangedEvent, ${event.status}');
        switch (event.status) {
          case PipelineStatus.cancelled:
          case PipelineStatus.abort:
            break;
          case PipelineStatus.success:
            pipelineRecordRepo.updateRecord(
                id: event.id,
                status: PipelineStatus.success,
                completedTime: DateTime.now());
            break;
          case PipelineStatus.failed:
            pipelineRecordRepo.updateRecord(
                id: event.id,
                status: PipelineStatus.failed,
                completedTime: DateTime.now());
            break;
          case PipelineStatus.running:
            pipelineRecordRepo.updateRecord(
                id: event.id, status: PipelineStatus.running);
            break;
          case PipelineStatus.idle:
            break;
        }
      });
    }

    return pipeline;
  }

  List<ModuleEntity> loadAllModules() {
    return repo.loadAll();
  }

  // 发布aar
  Pipeline _doCreateAndroidModulePipeline(
      ModuleEntity entity, Environment? env) {
    var depCheckStage = DependencyCheckStage();
    var codeFetchStage = CodeFetchStage();
    var releaseStage = AndroidPackageReleaseState();
    final p = Pipeline(
      stages: [depCheckStage, codeFetchStage, releaseStage],
      pipelineName: pipelineName,
      args: {
        CONFIG_OPERATE_MODULES: {entity.moduleName: entity},
        CONFIG_ALL_MODULES: repo.loadAllAsMap(),
      },
      environment: env,
    );

    return p;
  }

  // 发布pod
  Pipeline _doCreateIOSModulePipeline(ModuleEntity entity, Environment? env) {
    var depCheckStage = DependencyCheckStage();
    var codeFetchStage = CodeFetchStage();
    var releaseStage = IOSPackageReleaseState();
    final p = Pipeline(
      stages: [depCheckStage, codeFetchStage, releaseStage],
      pipelineName: pipelineName,
      args: {
        CONFIG_OPERATE_MODULES: {entity.moduleName: entity}
      },
      environment: env,
    );
    return p;
  }

  // 发布apk
  Pipeline _doCreateAndroidApkPipeline(ModuleEntity entity, Environment? env) {
    var depCheckStage = DependencyCheckStage();
    var codeFetchStage = CodeFetchStage();
    var releaseStage = AndroidAPKReleaseState();
    final p = Pipeline(
      stages: [depCheckStage, codeFetchStage, releaseStage],
      pipelineName: pipelineName,
      args: {
        CONFIG_OPERATE_MODULES: {entity.moduleName: entity},
        CONFIG_ALL_MODULES: repo.loadAllAsMap(),
      },
      environment: env,
    );

    return p;
  }
}
