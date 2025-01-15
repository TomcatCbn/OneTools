import 'package:code_tools/infra/db/database/work_space_db.dart';
import 'package:code_tools/screens/workspace_home/workspace_home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:platform_plugins/platform_plugins.dart';
import 'package:platform_utils/platform_utils.dart';

import '../infra/db/database/code_tools_db.dart';

class CodeTools implements PlatformPlugin, PlatformPluginLifeCycleListener {
  static final CodeTools _codeTools = CodeTools._();

  CodeTools._();

  factory CodeTools() => _codeTools;

  @override
  String get description => '代码仓库的管理，包括批量进行Pull、Push、Checkout';

  @override
  String get displayName => '项目Code仓库操作工具';

  @override
  String get pluginId => 'code_tools';

  @override
  String get workDirName => 'code_tools_plugin';

  @override
  Map<String, WidgetBuilder> get routes => {
        '/code_tools/home': (context) => const WorkSpaceHomeScreen(),
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
      // TODO: Handle this case.
      case Lifecycle.onPause:
      // TODO: Handle this case.
      case Lifecycle.onDestroy:
      // TODO: Handle this case.
    }
  }

  void _onPluginCreate() async {
    await $FloorWorkSpaceDatabase
        .databaseBuilder(
            '${settings.workSpace}/db/${CodeTools().pluginId}.db')
        .build()
        .then((onValue) {
      workSpaceDatabase = onValue;
    });
    await PlatformSettingBox().init();
  }
}
