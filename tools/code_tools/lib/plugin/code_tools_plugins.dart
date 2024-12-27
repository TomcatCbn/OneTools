import 'package:flutter/widgets.dart';
import 'package:platform_plugins/platform_plugins.dart';
import 'package:platform_utils/platform_utils.dart';

import '../infra/db/database/code_tools_db.dart';
import '../screens/home/home_screen.dart';

class CodeTools implements PlatformPlugin, PlatformPluginLifeCycleListener {
  static final CodeTools _codeTools = CodeTools._();

  CodeTools._();

  factory CodeTools() => _codeTools;

  @override
  String get description => '代码仓库的管理，包括批量进行Pull、Push、Checkout';

  @override
  String get displayName => 'Code仓库操作';

  @override
  String get pluginId => 'code_tools';

  @override
  String get workDirName => 'code_tools_plugin';

  @override
  Map<String, WidgetBuilder> get routes => {
        '/code_tools/home': (context) => const HomeScreen(),
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
    // 初始化数据库
    $FloorCodeToolsDatabase
        .databaseBuilder(
            '${settings.workSpace}/$workDirName/db/code_tools_database.db')
        .build()
        .then((onValue) {
      codeToolsDatabase = onValue;
    });
  }
}
