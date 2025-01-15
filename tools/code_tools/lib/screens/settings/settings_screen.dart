import 'package:flutter/material.dart';
import 'package:platform_utils/platform_utils.dart';

import '../../utils/settings_utils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool useProxy = false;

  @override
  void initState() {
    super.initState();
    useProxy = PlatformSettingBox().getBool(proxyKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text('proxy:'),
              Checkbox(
                  value: useProxy,
                  onChanged: (v) {
                    PlatformSettingBox().putBool(proxyKey, v!);
                    setState(() {
                      useProxy = v;
                    });
                  }),
              SizedBox(
                width: 400,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Proxy',
                  ),
                  onChanged: (v) {
                    PlatformSettingBox().putString(proxyValueKey, v);
                  },
                  controller: TextEditingController(
                      text: PlatformSettingBox().getString(proxyValueKey)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
