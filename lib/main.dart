import 'package:cicd_tools/plugin/cicd_tools_plugins.dart';
import 'package:code_tools/code_tools.dart';
import 'package:flutter/material.dart';
import 'package:onetools/toast/toast_impl.dart';
import 'package:platform_plugins/platform_plugins_mgmt.dart';
import 'package:platform_utils/platform_utils.dart';

import 'home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var codeTools = CodeTools();
  var cicdTools = CICDTools();
  // register lifecycle listener
  PlatformPluginsMgmt().addLifeCycleListener(codeTools.pluginId, codeTools);
  PlatformPluginsMgmt().addLifeCycleListener(cicdTools.pluginId, cicdTools);
  // register plugins
  PlatformPluginsMgmt().registerPlugin(codeTools);
  PlatformPluginsMgmt().registerPlugin(cicdTools);

  // register routes
  RouteManager().registerRoutes(codeTools.routes);
  RouteManager().registerRoutes(cicdTools.routes);

  // inject bridge implement into platform
  toastHelper = ToastImpl();

  runApp(const OneToolsApp());
}
