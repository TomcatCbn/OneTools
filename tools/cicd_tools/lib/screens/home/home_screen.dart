import 'dart:io';

import 'package:cicd_tools/screens/record/pipeline_record_screen.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_screenutils.dart';
import 'package:platform_utils/platform_utils.dart';
import 'package:platform_utils/platform_widget_ex.dart';

import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeScreen extends StatelessWidget {
  final Directory workDir;

  const HomeScreen({required this.workDir, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pipelines'),
      ),
      body: _BodyWidget(
        workDir: workDir,
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  final Directory workDir;

  const _BodyWidget({required this.workDir});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(workDir: workDir)..add(HomeInitEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
          builder: (builderContext, state) {
            return buildContent(builderContext, state);
          },
          listener: (context, state) {}),
    );
  }

  Widget buildContent(BuildContext context, HomeState state) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: ListView.separated(
              itemBuilder: (context, index) {
                var pipeline = state.pipelines[index];
                return ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(HomeClickPipelineEvent(
                          index: index, context: context));
                    },
                    child: Text(pipeline.name)).addPadding(EdgeInsets.symmetric(horizontal: 8.sp));
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: state.pipelines.length),
        ),
        const Text('Pipeline Record 列表'),
        Flexible(
          flex: 2,
          child: ListView.separated(
            itemBuilder: (context, index) {
              var record = state.records[index];
              return Column(
                children: [
                  Text(
                      '${record.id}.${record.pipelineName}: ${record.modulesName}'),
                  Text('$record'),
                  Text('查看Log: ${record.operationLog}').onTap(() {
                    Navigator.push(
                      navigatorKey.currentContext!,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return PipelineRecordScreen(
                          record: record,
                        );
                      }),
                    );
                  }),
                ],
              );
            },
            itemCount: state.records.length, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
          ).addPadding(EdgeInsets.all(8.sp)),
        ),
      ],
    );
  }
}
