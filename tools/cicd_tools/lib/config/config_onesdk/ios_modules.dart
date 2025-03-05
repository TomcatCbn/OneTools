import 'package:cicd_tools/cicd_tools.dart';

import '../../domain/entities/repo.dart';

ModuleEntity get apps {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/apps.git',
          path: '.'),
      moduleName: 'ios.vwbbox');

  return module;
}

ModuleEntity get debugTools {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/debugtools.git',
          path: '.'),
      moduleName: 'ios.vwbbox');

  return module;
}
ModuleEntity get uikit {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/oneuikit.git',
          path: '.'),
      moduleName: 'ios.uikit');

  return module;
}

ModuleEntity get sdk {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/vw-vehicle-ios-sdk.git',
          path: '.'),
      moduleName: 'ios.onesdk');

  return module;
}

ModuleEntity get appGroup {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/vwappgroup.git',
          path: '.'),
      moduleName: 'ios.appGroup');

  return module;
}


ModuleEntity get vwbbox {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
              'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/vwbbox.git',
          path: '.'),
      moduleName: 'ios.vwbbox');

  return module;
}

ModuleEntity get vwcategory {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/vwcategory.git',
          path: '.'),
      moduleName: 'ios.vwcategory');

  return module;
}

ModuleEntity get vwcloudConfig {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/vwcloudconfig.git',
          path: '.'),
      moduleName: 'ios.vwcloudConfig');

  return module;
}

ModuleEntity get deviceInfo {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/deviceinfo.git',
          path: '.'),
      moduleName: 'ios.deviceInfo');

  return module;
}

ModuleEntity get keychain {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/keychain.git',
          path: '.'),
      moduleName: 'ios.keychain');

  return module;
}
ModuleEntity get network {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/vwnetwork.git',
          path: '.'),
      moduleName: 'ios.vwnetwork');

  return module;
}

ModuleEntity get vwnetworkMonitorManager {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/vwnetworkmonitormanager.git',
          path: '.'),
      moduleName: 'ios.vwbbox');

  return module;
}

ModuleEntity get teeEncrypted {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/vwteeencrypted.git',
          path: '.'),
      moduleName: 'ios.vwbbox');

  return module;
}

ModuleEntity get vwutility {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/vwutility.git',
          path: '.'),
      moduleName: 'ios.vwutility');

  return module;
}

ModuleEntity get bleDataProcessor {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/xpbledataprocessor.git',
          path: '.'),
      moduleName: 'ios.bleDataProcessor');

  return module;
}

ModuleEntity get vehicleExt {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/xpvehicleext.git',
          path: '.'),
      moduleName: 'ios.vehicleExt');

  return module;
}

ModuleEntity get combo {
  var module = ModuleEntity(
      repo: RepoEntity(
          repoUrl:
          'git@gitlab.intranet.vwg-cea.cn:iix-cloud/one-sdk/ios/xpxcombosdk.git',
          path: '.'),
      moduleName: 'ios.combo');

  return module;
}