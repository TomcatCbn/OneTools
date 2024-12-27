import 'package:flutter/material.dart';

/// 路由管理
/// 路由注册中心
class RouteManager {
  static final RouteManager _sInstance = RouteManager._();

  factory RouteManager() => _sInstance;

  RouteManager._();

  final Map<String, WidgetBuilder> allRoutes = {};

  void registerRoute(String routeKey, WidgetBuilder routeBuild) {
    allRoutes[routeKey] = routeBuild;
  }

  void registerRoutes(Map<String, WidgetBuilder> routes) {
    allRoutes.addAll(routes);
  }
}
