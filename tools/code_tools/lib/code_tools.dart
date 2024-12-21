library code_tools;

import 'package:platform_plugins/platform_plugins.dart';

class CodeTools implements PlatformPlugin {
  @override
  String get description => '代码仓库的管理，包括批量进行Pull、Push、Checkout';

  @override
  String get displayName => 'Code仓库操作';

  @override
  String get pluginId => 'code_tools';
}
