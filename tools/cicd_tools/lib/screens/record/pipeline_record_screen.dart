import 'dart:io';

import 'package:cicd_tools/domain/entities/cicd_pipeline.dart';
import 'package:flutter/material.dart';

class PipelineRecordScreen extends StatefulWidget {
  final PipelineRecord record;

  const PipelineRecordScreen({required this.record, super.key});

  @override
  State<StatefulWidget> createState() {
    return _BodyStateWidget();
  }
}

class _BodyStateWidget extends State<PipelineRecordScreen> {
  _BodyStateWidget();

  String logContent = '';

  @override
  void initState() {
    super.initState();
    File(widget.record.operationLog).readAsString().then((onValue) {
      logContent = onValue;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pipeline Record查看'),
      ),
      body: SingleChildScrollView(
        child: SelectableText(logContent),
      ),
    );
  }
}
