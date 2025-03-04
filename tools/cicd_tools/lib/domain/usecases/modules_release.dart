import 'package:cicd_tools/cicd_tools.dart';
import 'package:cicd_tools/domain/entities/cicd_stage.dart';
import 'package:cicd_tools/domain/entities/stage_config.dart';
import 'package:cicd_tools/domain/services/operator_service.dart';
import 'package:platform_utils/platform_utils.dart';

import '../../plugin/cicd_tools_plugins.dart';
import '../entities/cicd_pipeline.dart';
import '../entities/publish_type.dart';

class PipelineUseCase {
  final ModuleRepo repo;
  final String pipelineName;

  PipelineUseCase({required this.repo, required this.pipelineName}) {
    // 开启单独的日志，方便回溯
    var timestamp = formatDate(
        DateTime.now(), [yyyy, '-', mm, '-', dd, '-', HH, '-', nn, '-', ss]);
    String fileName = '${OperatorService().curr?.name}-$timestamp.log';
    String filePath = '${CICDTools().workDirName}/logs/$pipelineName/$fileName';
    Logger.logToNewFile(filePath: filePath);
  }

  Pipeline? createPipeline(PublishType type, ModuleEntity entity,
      {required String branch}) {
    Logger.i(msg: 'createPipeline, $type, ${entity.moduleName}, $branch');
    // 设置目标分支
    entity.targetBranch = branch;
    Pipeline? pipeline;
    switch (type) {
      case PublishType.apk:
        break;
      case PublishType.ipa:
        break;
      case PublishType.aar:
        pipeline = _doCreateAndroidModulePipeline(entity);
        break;
      case PublishType.pod:
        pipeline = _doCreateIOSModulePipeline(entity);
        break;
    }

    return pipeline;
  }

  List<ModuleEntity> loadAllModules() {
    return repo.loadAll();
  }

  Pipeline? _doCreateAndroidModulePipeline(ModuleEntity entity) {
    var depCheckStage = DependencyCheckStage();
    var codeFetchStage = CodeFetchStage();
    var releaseStage = AndroidPackageReleaseState();
    final p = Pipeline(
        stages: [depCheckStage, codeFetchStage, releaseStage],
        pipelineName: 'Android-AAR-Release',
        args: {
          CONFIG_OPERATE_MODULES: {entity.moduleName: entity},
          CONFIG_ALL_MODULES: repo.loadAllAsMap(),
        });

    return p;
  }

  Pipeline? _doCreateIOSModulePipeline(ModuleEntity entity) {
    var depCheckStage = DependencyCheckStage();
    var codeFetchStage = CodeFetchStage();
    var releaseStage = IOSPackageReleaseState();
    final p = Pipeline(
        stages: [depCheckStage, codeFetchStage, releaseStage],
        pipelineName: 'iOS-Pod-Release',
        args: {
          CONFIG_OPERATE_MODULES: {entity.moduleName: entity}
        });
    return p;
  }
}
