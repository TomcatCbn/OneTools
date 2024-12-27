library platform_plugins;

import 'package:flutter/cupertino.dart';

/// 平台插件定义，任何需要扩展的插件都需要实现这个基类
abstract class PlatformPlugin {
  /// 全局唯一标识
  String get pluginId;

  /// 界面展示的名称
  String get displayName;

  /// 插件的描述
  String get description;

  /// 插件的工作空间目录名称，基于整个one tools的目录
  String get workDirName;

  /// all routes in plugin
  Map<String, WidgetBuilder> get routes;
}

class PlatformPluginWrapper {
  final PlatformPlugin plugin;

  Lifecycle status = Lifecycle.onCreate;

  PlatformPluginWrapper({required this.plugin});
}

abstract class PlatformPluginLifecycleOwner {
  void addLifeCycleListener(
      String pluginId, PlatformPluginLifeCycleListener listener);

  void removeLifeCycleListener(
      String pluginId, PlatformPluginLifeCycleListener listener);
}

abstract class PlatformPluginLifeCycleListener {
  void onLifeCycleChanged(String pluginId, Lifecycle newLifecycle);
}

enum Lifecycle {
  onCreate,
  onStart,
  onResume,
  onPause,
  onDestroy,
}

// global context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();