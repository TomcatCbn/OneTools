import 'dart:io';

import 'package:cicd_tools/infra/db/database/cicd_tools_db.dart';
import 'package:cicd_tools/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:platform_plugins/platform_plugins.dart';
import 'package:platform_utils/platform_utils.dart';

class CICDTools implements PlatformPlugin, PlatformPluginLifeCycleListener {
  static final CICDTools _codeTools = CICDTools._();

  CICDTools._();

  factory CICDTools() => _codeTools;

  @override
  String get description => 'CICD（包发布，应用发布，代码合并等）';

  @override
  String get displayName => '项目CICD工具';

  @override
  String get pluginId => 'cicd_tools';

  @override
  String get workDirName => '${settings.workSpace}/cicd_tools_plugin';

  @override
  Map<String, WidgetBuilder> get routes => {
        '/cicd_tools/home': (context) =>
            HomeScreen(workDir: Directory('${settings.workSpace}/$pluginId')),
      };

  @override
  void onLifeCycleChanged(String pluginId, Lifecycle newLifecycle) {
    if (pluginId != this.pluginId) {
      return;
    }
    switch (newLifecycle) {
      case Lifecycle.onCreate:
        _onPluginCreate();
        break;
      case Lifecycle.onStart:
        break;
      case Lifecycle.onResume:
      case Lifecycle.onPause:
      case Lifecycle.onDestroy:
    }
  }

  void _onPluginCreate() async {
    await $FloorCICDToolsDatabase
        .databaseBuilder(
        '${CICDTools().workDirName}/db/${CICDTools().pluginId}.db')
        .build()
        .then((onValue) {
      cicdToolsDatabase = onValue;
    });
  }

  @override
  String get homeRoute => '/cicd_tools/home';
}
