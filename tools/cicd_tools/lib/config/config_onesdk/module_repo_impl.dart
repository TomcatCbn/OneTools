import 'package:cicd_tools/cicd_tools.dart';
import 'package:cicd_tools/domain/entities/repo.dart';

class ModuleRepoImpl extends ModuleRepo {
  Map<String, ModuleEntity> modules = {};

  ModuleRepoImpl() {
    // ---------------- tools ----------------
    var cliTools = ModuleEntity(
        repo: RepoEntity(
            repoUrl:
            'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/cli-tools.git',
            path: 'cli-tools'),
        moduleName: 'cli-tools');

    modules[cliTools.moduleName] = cliTools;

    // ---------------- android --------------
    var xpBaseTools = ModuleEntity(
        repo: RepoEntity(
            repoUrl:
                'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xpbasetools.git',
            path: 'VWBaseTools'),
        moduleName: 'android.xpbasetools');
    // 添加dependency
    xpBaseTools.dependencyModules.add(cliTools.moduleName);
    modules[xpBaseTools.moduleName] = xpBaseTools;

    var apps = ModuleEntity(
        repo: RepoEntity(
            repoUrl:
            'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/apps.git',
            path: 'vwapptest'),
        moduleName: 'android.apps');
    // 添加dependency
    apps.dependencyModules.add(cliTools.moduleName);
    modules[apps.moduleName] = apps;

  }

  @override
  ModuleEntity? getBy(String moduleName) {
    return modules[moduleName];
  }

  @override
  List<ModuleEntity> loadAll() {
    return modules.values.toList(growable: false);
  }

  @override
  Map<String, ModuleEntity> loadAllAsMap() {
    return modules;
  }}
