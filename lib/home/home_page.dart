import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:platform_plugins/platform_plugins.dart';
import 'package:platform_plugins/platform_plugins_mgmt.dart';
import 'package:platform_utils/platform_utils.dart';
import 'package:platform_utils/platform_screenutils.dart';

class OneToolsApp extends StatelessWidget {
  const OneToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    var homeWidget = const MyHomePage(title: 'Developer Tools Home Page');

    var materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Developer Tools',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      routes: RouteManager().allRoutes,
      navigatorKey: navigatorKey,
      home: homeWidget,
    );

    // 嵌套一个屏幕适配方案
    var screenUtilInit = ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: materialApp,
    );

    return screenUtilInit;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<PlatformPlugin> _plugins;

  @override
  void initState() {
    super.initState();
    _plugins = PlatformPluginsMgmt().allPlugins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ..._plugins.map((p) => ElevatedButton(
                  child: Text(p.displayName),
                  onPressed: () {
                    Navigator.pushNamed(context, '/code_tools/home');
                  },
                ))
          ],
        ),
      ),
    );
  }
}
