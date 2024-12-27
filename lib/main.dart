import 'package:code_tools/code_tools.dart';
import 'package:flutter/material.dart';
import 'package:onetools/toast/toast_impl.dart';
import 'package:platform_plugins/platform_plugins_mgmt.dart';
import 'package:platform_utils/platform_utils.dart';

import 'home/home_page.dart';

void main() async {
  var codeTools = CodeTools();
  // register lifecycle listener
  PlatformPluginsMgmt().addLifeCycleListener(codeTools.pluginId, codeTools);
  // register plugins
  PlatformPluginsMgmt().registerPlugin(codeTools);

  // register routes
  RouteManager().registerRoutes(codeTools.routes);

  // inject bridge implement into platform
  toastHelper = ToastImpl();

  runApp(const OneToolsApp());
}
