import 'dart:io';

import 'package:cicd_tools/domain/entities/cicd_pipeline.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_bloc.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_event.dart';
import 'package:cicd_tools/screens/pipeline/pipeline_state.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_screenutils.dart';
import 'package:platform_utils/platform_utils.dart';

class PipelineHomeScreen extends StatelessWidget {
  final Directory workDir;
  final String pipelineName;
  final PipelineType pipelineType;

  const PipelineHomeScreen(
      {required this.workDir,
      required this.pipelineName,
      required this.pipelineType,
      super.key});

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
        pipelineType: pipelineType,
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  final Directory workDir;
  final String pipelineName;
  final PipelineType pipelineType;

  const _BodyWidget({
    required this.workDir,
    required this.pipelineName,
    required this.pipelineType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PipelineHomeBloc(
          workDir: workDir,
          pipelineName: pipelineName,
          pipelineType: pipelineType)
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
        TextFormField(
          controller: context.read<PipelineHomeBloc>().filterController,
          onChanged: (t) => context
              .read<PipelineHomeBloc>()
              .add(ModuleKeyWordChangedEvent(keyWord: t)),
          decoration: const InputDecoration(
            labelText: 'Module列表筛选', // 标签
            hintText: 'Module关键词搜索', // 提示文本
            border: OutlineInputBorder(), // 设置边框样式
          ),
        ),
        SizedBox(height: 10.sp),
        _buildModuleSelector(context, state),

        SizedBox(height: 10.sp),
        // 分支
        const Text('分支选择'),
        _buildBranchSelector(context, state.selected),
        // tag
        SizedBox(height: 10.sp),
        // 启动
        ElevatedButton(
          onPressed: state.pipelineBtnState == BtnState.enable
              ? () {
                  context.read<PipelineHomeBloc>().add(PipelineStartEvent());
                }
              : null,
          child: Text(_getPipelineBtnString(state.pipelineBtnState)),
        )
      ],
    );
  }

  String _getPipelineBtnString(BtnState btnState) {
    switch (btnState) {
      case BtnState.enable:
        return '启动Pipeline';
      case BtnState.inProgress:
        return '进行中';
      case BtnState.disable:
        return '未就绪';
    }
  }

  Widget _buildModuleSelector(BuildContext context, PipelineHomeState state) {
    return DropdownMenu<ModuleState>(
      controller: TextEditingController(text: state.selected?.moduleName),
      menuHeight: 0.6.sh,
      width: double.infinity,
      label: const Text('Module to select'),
      dropdownMenuEntries: state.modules
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
