import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_utils/platform_utils.dart';

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
    return ListView.separated(
        itemBuilder: (context, index) {
          var pipeline = state.pipelines[index];
          return ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(
                    HomeClickPipelineEvent(index: index, context: context));
              },
              child: Text(pipeline.name));
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: state.pipelines.length);
  }
}
