import 'dart:io';

import 'package:cicd_tools/screens/pipeline/pipeline_bloc.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_event.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_state.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_utils.dart';

class PipelineHomeScreen extends StatelessWidget {
  final Directory workDir;
  final String pipelineName;

  const PipelineHomeScreen(
      {required this.workDir, required this.pipelineName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(pipelineName),
      ),
      body: _BodyWidget(
        workDir: workDir,
        pipelineName: pipelineName,

      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  final Directory workDir;
  final String pipelineName;

  const _BodyWidget({required this.workDir, required this.pipelineName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PipelineHomeBloc(workDir: workDir,pipelineName: pipelineName )..add(PipelineInitEvent()),
      child: BlocConsumer<PipelineHomeBloc, PipelineHomeState>(
          builder: (builderContext, state) {
            return buildContent(builderContext, state);
          },
          listener: (context, state) {}),
    );
  }

  Widget buildContent(BuildContext context, PipelineHomeState state) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ElevatedButton(
              onPressed: () {
                // context.read<HomeBloc>().add(
                //     HomeClickPipelineEvent(index: index, context: context));
              },
              child: Text(''));
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: 0);
  }
}
