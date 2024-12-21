import 'package:code_tools/code_tools.dart';
import 'package:flutter/material.dart';
import 'package:platform_plugins/platform_plugins_mgmt.dart';

import 'home/home_page.dart';

void main() {
  // register plugins

  PlatformPluginsMgmt().registerPlugin(CodeTools());

  runApp(const MyApp());
}
