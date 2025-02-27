import 'package:cicd_tools/cicd_tools.dart';
import 'package:cicd_tools/domain/entities/repo.dart';

class ModuleRepoImpl extends ModuleRepo {
  Map<String, ModuleEntity> modules = {};

  ModuleRepoImpl() {
    var moduleEntity1 = ModuleEntity(
        repo: RepoEntity(
            repoUrl:
                'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xpbasetools.git',
            path: 'xpbasetools'),
        moduleName: 'android.xpbasetools');

    modules[moduleEntity1.moduleName] = moduleEntity1;
  }

  @override
  ModuleEntity? getBy(String moduleName) {
    return modules[moduleName];
  }

  @override
  List<ModuleEntity> loadAll() {
    return modules.values.toList(growable: false);
  }
}
