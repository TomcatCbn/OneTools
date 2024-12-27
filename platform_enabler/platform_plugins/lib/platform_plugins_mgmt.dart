import 'dart:collection';

import 'package:platform_plugins/constants/constant.dart';
import 'package:platform_plugins/platform_plugins.dart';
import 'package:platform_utils/platform_utils.dart';

/// 平台插件管理器
class PlatformPluginsMgmt implements PlatformPluginLifecycleOwner {
  static final PlatformPluginsMgmt _sInstance = PlatformPluginsMgmt._();

  PlatformPluginsMgmt._();

  factory PlatformPluginsMgmt() => _sInstance;

  final HashMap<String, PlatformPluginWrapper> _plugins =
      HashMap<String, PlatformPluginWrapper>();

  final HashMap<String, Set<PlatformPluginLifeCycleListener>>
      _lifecycleListeners =
      HashMap<String, Set<PlatformPluginLifeCycleListener>>();

  void registerPlugin(PlatformPlugin plugin) {
    Logger.i(
      msg: 'registerPlugin, ${plugin.pluginId}, ${plugin.displayName}',
      tag: tag,
    );

    var wrapper = PlatformPluginWrapper(plugin: plugin);

    _plugins[plugin.pluginId] = wrapper;
    _moveLifeCycle(wrapper, Lifecycle.onCreate);
  }

  void unregisterPlugin(String pluginId) {
    Logger.i(
      msg: 'unregisterPlugin, $pluginId',
      tag: tag,
    );
    _plugins.remove(pluginId);
  }

  List<PlatformPlugin> allPlugins() {
    return _plugins.values.map((e) => e.plugin).toList(growable: false);
  }

  @override
  void addLifeCycleListener(
      String pluginId, PlatformPluginLifeCycleListener listener) {
    if (!_lifecycleListeners.containsKey(pluginId)) {
      _lifecycleListeners[pluginId] = HashSet();
    }
    _lifecycleListeners[pluginId]!.add(listener);
  }

  @override
  void removeLifeCycleListener(
      String pluginId, PlatformPluginLifeCycleListener listener) {
    if (_lifecycleListeners.containsKey(pluginId)) {
      _lifecycleListeners[pluginId]!.remove(listener);
    }
  }

  void _notifyLifeCycle(String pluginId, Lifecycle lifecycle) {
    if (_plugins.containsKey(pluginId)) {
      var map = _lifecycleListeners[pluginId]!;
      for (var e in map) {
        e.onLifeCycleChanged(pluginId, lifecycle);
      }
    }
  }

  void _moveLifeCycle(PlatformPluginWrapper pluginWrapper, Lifecycle onCreate) {
    pluginWrapper.status = Lifecycle.onCreate;

    _notifyLifeCycle(pluginWrapper.plugin.pluginId, Lifecycle.onCreate);
  }
}
