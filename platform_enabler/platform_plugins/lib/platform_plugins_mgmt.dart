import 'dart:collection';

import 'package:platform_plugins/constants/constant.dart';
import 'package:platform_plugins/platform_plugins.dart';
import 'package:platform_utils/platform_utils.dart';

/// 平台插件管理器
class PlatformPluginsMgmt {
  static final PlatformPluginsMgmt _sInstance = PlatformPluginsMgmt._();

  PlatformPluginsMgmt._();

  factory PlatformPluginsMgmt() => _sInstance;

  final HashMap<String, PlatformPlugin> _plugins =
      HashMap<String, PlatformPlugin>();

  void registerPlugin(PlatformPlugin plugin) {
    Logger.i(
      msg: 'registerPlugin, ${plugin.pluginId}, ${plugin.displayName}',
      tag: tag,
    );

    _plugins[plugin.pluginId] = plugin;
  }

  void unregisterPlugin(String pluginId) {
    Logger.i(
      msg: 'unregisterPlugin, $pluginId',
      tag: tag,
    );
    _plugins.remove(pluginId);
  }

  List<PlatformPlugin> allPlugins() {
    return _plugins.values.toList(growable: false);
  }
}
