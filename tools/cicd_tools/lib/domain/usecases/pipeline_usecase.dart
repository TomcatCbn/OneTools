import 'package:cicd_tools/cicd_tools.dart';
import 'package:cicd_tools/domain/entities/stage_config.dart';
import 'package:cicd_tools/domain/repo/pipeline_record_repo.dart';
import 'package:cicd_tools/domain/services/operator_service.dart';
import 'package:cicd_tools/infra/pipeline_record_repo.dart';
import 'package:platform_utils/platform_stream_enhance.dart' as streamen;
import 'package:platform_utils/platform_utils.dart';

import '../../plugin/cicd_tools_plugins.dart';
import '../entities/cicd_pipeline.dart';
import '../entities/stages/android_apk_stage.dart';
import '../entities/stages/android_package_release_stage.dart';
import '../entities/stages/code_fetch_stage.dart';
import '../entities/stages/dependency_check_stage.dart';
import '../entities/stages/ios_ipa_stage.dart';
import '../entities/stages/iso_package_release_stage.dart';
import '../entities/stages/tag_stage.dart';

class PipelineUseCase {
  final ModuleRepo repo;
  final String pipelineName;
  final PipelineRecordRepo pipelineRecordRepo = PipelineRecordRepoImpl();
  String operationLog = '';

  PipelineUseCase({required this.repo, required this.pipelineName}) {
    // 开启单独的日志，方便回溯
    var timestamp = formatDate(
        DateTime.now(), [yyyy, '-', mm, '-', dd, '-', HH, '-', nn, '-', ss]);
    String fileName =
        '${OperatorService().curr?.name ?? 'unknown'}-$timestamp.log';
    String filePath = '${CICDTools().workDirName}/logs/$pipelineName/$fileName';
    operationLog = filePath;
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
            'createPipeline, pipelineName: $pipelineName, moduleName: ${entity.moduleName}, branch: $branch, operator: ${OperatorService().operatorName}');
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
        pipeline = _doCreateIOSIpaPipeline(entity, env);
        break;
      case PipelineType.androidCheckModule:
      // TODO: Handle this case.
      case PipelineType.iosCheckModule:
        // TODO: Handle this case.
        break;
    }

    if (pipeline != null) {
      final p = pipeline;
      p.operationLog = operationLog;
      // save in db
      var pipelineRecord = PipelineRecord(
        pipelineName: pipelineName,
        createTime: DateTime.now(),
        operator: OperatorService().curr?.name ?? 'unknown',
        operationLog: operationLog,
        modulesName: [entity.moduleName],
      );
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
    var depCheckStage = DependencyCheckForAndroidStage();
    var codeFetchStage = CodeFetchStage();
    var releaseStage = AndroidPackageReleaseStage();
    var tagStage = TAGStage();
    final p = Pipeline(
      stages: [depCheckStage, codeFetchStage, releaseStage, tagStage],
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
    var depCheckStage = DependencyCheckForIOSStage();
    var codeFetchStage = CodeFetchStage();
    var releaseStage = IOSPackageReleaseStage();
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

  // 发布apk
  Pipeline _doCreateAndroidApkPipeline(ModuleEntity entity, Environment? env) {
    var depCheckStage = DependencyCheckForAndroidStage();
    var codeFetchStage = CodeFetchStage();
    var releaseStage = AndroidAPKReleaseStage();
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

  // 发布ipa
  Pipeline _doCreateIOSIpaPipeline(ModuleEntity entity, Environment? env) {
    var depCheckStage = DependencyCheckForIOSStage();
    var codeFetchStage = CodeFetchStage();
    var releaseStage = IOSIPAReleaseStage();
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
