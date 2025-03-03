import 'package:cicd_tools/cicd_tools.dart';
import 'package:cicd_tools/domain/entities/cicd_stage.dart';
import 'package:cicd_tools/domain/entities/stage_config.dart';
import 'package:platform_utils/platform_logger.dart';

import '../entities/cicd_pipeline.dart';
import '../entities/publish_type.dart';

class ModuleReleaseUseCase {
  final ModuleRepo repo;

  ModuleReleaseUseCase({required this.repo});

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
    var codeFetchStage = CodeFetchStage();
    var releaseStage = AndroidPackageReleaseState();
    final p = Pipeline(
        stages: [codeFetchStage, releaseStage],
        pipelineName: 'Android-AAR-Release',
        args: {
          CONFIG_MODULES: {entity.moduleName: entity}
        });

    return p;
  }

  Pipeline? _doCreateIOSModulePipeline(ModuleEntity entity) {
    var codeFetchStage = CodeFetchStage();
    var releaseStage = IOSPackageReleaseState();
    final p = Pipeline(
        stages: [codeFetchStage, releaseStage],
        pipelineName: 'iOS-Pod-Release',
        args: {
          CONFIG_MODULES: {entity.moduleName: entity}
        });
    return p;
  }
}
