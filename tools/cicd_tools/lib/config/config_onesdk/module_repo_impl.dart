import 'package:cicd_tools/cicd_tools.dart';
import 'package:cicd_tools/domain/entities/repo.dart';

import 'android_modules.dart' as aos;
import 'ios_modules.dart' as ios;

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
    {
      {
        var module = aos.apps;
        modules[module.moduleName] = module;
      }

      {
        var module = aos.ext;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.tripOrEnergy;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.sdkBase;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.sdkCore;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.sdkFunc;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.combo;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.framework;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.debugTools;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.libblekt;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.libmqtt;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.protocolV3;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.libApiCache;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.libOnePlayer;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.libResSdk;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.ipc;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.appState;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.baseTool;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.bbox;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.fingerPrint;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.mmkv;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.network;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.networkBase;
        modules[module.moduleName] = module;
      }

      {
        var module = aos.tee;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.baseTool;
        modules[module.moduleName] = module;
      }

      {
        var module = aos.uikit;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.theme;
        modules[module.moduleName] = module;
      }
      {
        var module = aos.intl;
        modules[module.moduleName] = module;
      }
    }
    // ------------------ ios -------------------
    {
      {
        var module = ios.apps;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.debugTools;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.uikit;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.sdk;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.appGroup;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.vwbbox;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.vwcategory;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.vwcloudConfig;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.deviceInfo;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.keychain;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.network;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.vwnetworkMonitorManager;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.teeEncrypted;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.vwutility;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.bleDataProcessor;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.vehicleExt;
        modules[module.moduleName] = module;
      }
      {
        var module = ios.combo;
        modules[module.moduleName] = module;
      }
    }
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
  }

// ----------------------------------------------
}
