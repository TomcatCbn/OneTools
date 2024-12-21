library platform_plugins;

/// 平台插件定义，任何需要扩展的插件都需要实现这个基类
abstract class PlatformPlugin {
  /// 全局唯一标识
  String get pluginId;

  /// 界面展示的名称
  String get displayName;

  /// 插件的描述
  String get description;
}

abstract class PlatformPluginLifecycleOwner {
  void addLifeCycleListener(PlatformPluginLifeCycleListener listener);

  void removeLifeCycleListener(PlatformPluginLifeCycleListener listener);
}

abstract class PlatformPluginLifeCycleListener {
  void onLifeCycleChanged(Lifecycle newLifecycle, Lifecycle oldLifeCycle);
}

enum Lifecycle {
  onCreate,
  onStart,
  onResume,
  onPause,
  onDestroy,
}
