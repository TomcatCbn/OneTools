import 'dart:io';

import 'package:cicd_tools/screens/pipeline/pipeline_bloc.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_event.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_state.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_screenutils.dart';
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
      create: (context) =>
          PipelineHomeBloc(workDir: workDir, pipelineName: pipelineName)
            ..add(PipelineInitEvent()),
      child: BlocConsumer<PipelineHomeBloc, PipelineHomeState>(
          builder: (builderContext, state) {
            return buildContent(builderContext, state);
          },
          listener: (context, state) {}),
    );
  }

  Widget buildContent(BuildContext context, PipelineHomeState state) {
    return Column(
      children: [
        // 模块
        const Text('模块选择'),
        _buildModuleSelector(context, state.modules, state.selected),
        // 分支
        const Text('分支选择'),
        _buildBranchSelector(context, state.selected),
        // tag

        // 启动
        ElevatedButton(
          onPressed: () {
            context.read<PipelineHomeBloc>().add(PipelineStartEvent());
          },
          child: const Text('启动Pipeline'),
        )
      ],
    );
  }

  Widget _buildModuleSelector(
      BuildContext context, List<ModuleState> modules, ModuleState? selected) {
    return DropdownMenu<ModuleState>(
      controller: TextEditingController(text: selected?.moduleName ?? ''),
      menuHeight: 0.6.sh,
      width: double.infinity,
      label: const Text('Module to select'),
      dropdownMenuEntries: modules
          .map((e) => DropdownMenuEntry<ModuleState>(
                value: e,
                label: e.moduleName,
              ))
          .toList(),
      onSelected: (module) => context
          .read<PipelineHomeBloc>()
          .add(ModuleSelectEvent(moduleState: module)),
    );
  }

  Widget _buildBranchSelector(BuildContext context, ModuleState? module) {
    return DropdownMenu<String>(
      controller: TextEditingController(text: module?.selectBranch ?? ''),
      menuHeight: 0.6.sh,
      width: double.infinity,
      label: const Text('Branch to select'),
      dropdownMenuEntries: (module?.branches ?? [])
          .map((e) => DropdownMenuEntry(
                value: e,
                label: e,
              ))
          .toList(),
      onSelected: (branch) => context
          .read<PipelineHomeBloc>()
          .add(BranchSelectEvent(branch: branch ?? '')),
    );
  }
}
