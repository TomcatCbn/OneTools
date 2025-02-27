import 'package:cicd_tools/cicd_tools.dart';

import '../entities/cicd_pipeline.dart';
import '../entities/publish_type.dart';

class ModuleReleaseUseCase {

  final ModuleRepo repo;

  ModuleReleaseUseCase({required this.repo});

  Pipeline? createPipeline(PublishType type, ) {
    Pipeline? pipeline;
    switch (type) {
      case PublishType.apk:
        break;
      case PublishType.ipa:
        break;
      case PublishType.aar:
        pipeline = _doCreateAndroidModulePipeline();
        break;
      case PublishType.pod:
        pipeline = _doCreateIOSModulePipeline();
        break;
    }

    return pipeline;
  }

  List<ModuleEntity> loadAllModules() {
    return repo.loadAll();
  }

  Pipeline? _doCreateAndroidModulePipeline() {

  }

  Pipeline? _doCreateIOSModulePipeline() {

  }
}
