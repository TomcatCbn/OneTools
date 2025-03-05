import 'package:cicd_tools/cicd_tools.dart';

import '../../domain/entities/repo.dart';

ModuleEntity get apps {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/apps.git',
          path: 'vwapptest'),
      moduleName: 'android.apps');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

// ------------------------- biz -------------------------
ModuleEntity get ext {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/vehiclelinkext.git',
          path: 'Ext'),
      moduleName: 'android.Ext');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get tripOrEnergy {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/vehiclelinkext.git',
          path: 'TripOrEnergy'),
      moduleName: 'android.tripOrEnergy');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get sdkBase {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/vw-vehicle-android-sdk.git',
          path: 'Base'),
      moduleName: 'android.sdkBase');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get sdkCore {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/vw-vehicle-android-sdk.git',
          path: 'Core'),
      moduleName: 'android.core');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get sdkFunc {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/vw-vehicle-android-sdk.git',
          path: 'Function'),
      moduleName: 'android.sdkFunc');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get combo {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/XCombo.git',
          path: 'XCombo'),
      moduleName: 'android.combo');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

// ------------------------- fm --------------------------
ModuleEntity get framework {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/framework.git',
          path: 'core'),
      moduleName: 'android.framework');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get debugTools {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/debugtools.git',
          path: 'debugTools'),
      moduleName: 'android.debugTools');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get libblekt {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/libblekt.git',
          path: 'lib_blekt'),
      moduleName: 'android.libblekt');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get libmqtt {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/libmqtt.git',
          path: 'lib_mqtt'),
      moduleName: 'android.libmqtt');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get protocolV3 {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/protocol-v3.git',
          path: 'protocol-v3'),
      moduleName: 'android.protocolV3');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get libApiCache {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/resourcesdk.git',
          path: 'libApiCache'),
      moduleName: 'android.libApiCache');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get libOnePlayer {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/resourcesdk.git',
          path: 'libOnePlayer'),
      moduleName: 'android.libOnePlayer');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get libResSdk {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/resourcesdk.git',
          path: 'libResSdk'),
      moduleName: 'android.libResSdk');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get ipc {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xipc.git',
          path: 'lib_vwipc'),
      moduleName: 'android.libvwipc');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get appState {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xpappstate.git',
          path: 'VWAPPState'),
      moduleName: 'android.vwAppState');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get baseTool {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xpbasetools.git',
          path: 'VWBaseTools'),
      moduleName: 'android.xpbasetools');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get bbox {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xpbox.git',
          path: 'VWBBox'),
      moduleName: 'android.vwbbox');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get fingerPrint {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xpfingerprint.git',
          path: 'VWFingerPrint'),
      moduleName: 'android.fingerPrint');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get mmkv {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xpmmkv.git',
          path: 'VWMMKV'),
      moduleName: 'android.vwmmkv');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get network {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xpnetwork.git',
          path: 'VWNetwork'),
      moduleName: 'android.network');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get networkBase {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xpnetwork.git',
          path: 'base'),
      moduleName: 'android.networkBase');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get tee {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/xtee.git',
          path: 'xtee'),
      moduleName: 'android.tee');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

// --------------------- ui -----------------------
ModuleEntity get uikit {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/OneUIKit.git',
          path: 'uiKit'),
      moduleName: 'android.uiKit');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get theme {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/OneUIKit.git',
          path: 'theme'),
      moduleName: 'android.theme');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}

ModuleEntity get intl {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/android/OneUIKit.git',
          path: 'intl'),
      moduleName: 'android.intl');
  // 添加dependency
  module.dependencyModules.add('cli-tools');
  return module;
}
