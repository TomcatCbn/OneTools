import 'package:code_tools/domain/entities/code_repo.dart';
import 'package:code_tools/screens/code_repo_batch_operate/batch_operate_event.dart';
import 'package:code_tools/screens/code_repo_batch_operate/batch_operate_state.dart';
import 'package:code_tools/screens/code_repo_batch_operate/widgets/code_repo_item.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_screenutils.dart';
import 'package:platform_utils/platform_utils.dart';

import '../../domain/entities/git_action.dart';
import 'batch_operate_bloc.dart';

class BatchOperateScreen extends StatelessWidget {
  final CodeRepoOperation operation;
  final List<CodeRepoEntity> codeRepoEntities;

  const BatchOperateScreen(
      {super.key, required this.operation, required this.codeRepoEntities});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BatchOperateBloc(codeRepoEntities: codeRepoEntities)
        ..add(BatchOperateInitEvent()),
      child: BlocConsumer<BatchOperateBloc, BatchOperateState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('多仓库批量操作'),
                actions: [
                  InkWell(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: const Text('当前全选'),
                      ),
                    ),
                    onTap: () {
                      context
                          .read<BatchOperateBloc>()
                          .add(BatchOperateAllSelectEvent(allSelected: true));
                    },
                  ),
                  InkWell(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: const Text('当前全不选'),
                      ),
                    ),
                    onTap: () {
                      context
                          .read<BatchOperateBloc>()
                          .add(BatchOperateAllSelectEvent(allSelected: false));
                    },
                  ),
                  InkWell(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: const Text('Confirm'),
                      ),
                    ),
                    onTap: () {
                      context
                          .read<BatchOperateBloc>()
                          .add(BatchOperateConfirmEvent());
                    },
                  ),
                ],
              ),
              body: Column(
                children: [
                  _buildOperationConfig(context, state),
                  _buildReposList(context, state),
                ],
              ),
            );
          },
          listener: (c, s) {}),
    );
  }

  Widget _buildOperationConfig(BuildContext context, BatchOperateState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: context.read<BatchOperateBloc>().filtercontroller,
            onChanged: (t) => context
                .read<BatchOperateBloc>()
                .add(BatchOperateSearchKeyWordEvent(keyWord: t)),
            decoration: const InputDecoration(
              labelText: '搜索筛选', // 标签
              hintText: '关键词搜索', // 提示文本
              border: OutlineInputBorder(), // 设置边框样式
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          if (operation == CodeRepoOperation.checkout)
            _buildBranchSelector(context, state),
          if (operation == CodeRepoOperation.branch) _buildBranchName(context, state),
          if (operation == CodeRepoOperation.tag) _buildTagName(context, state),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }

  Widget _buildReposList(BuildContext context, BatchOperateState state) {
    return Flexible(
      flex: 2,
      child: ListView.separated(
          itemBuilder: (context, index) {
            var codeRepo = state.codeRepos[index];
            return CodeRepoSimpleItemWidget(
              onClickListener: () {
                context.read<BatchOperateBloc>().add(BatchOperateSelectEvent(
                    codeRepoName: codeRepo.codeRepoName));
              },
              codeRepoState: codeRepo,
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                height: 16.h,
              ),
          itemCount: state.codeRepos.length),
    );
  }

  Widget _buildBranchSelector(BuildContext context, BatchOperateState state) {
    return DropdownMenu<String>(
      controller: TextEditingController(text: state.targetName),
      menuHeight: 0.6.sh,
      width: double.infinity,
      label: const Text('Branch to select'),
      dropdownMenuEntries: state.branchesForSelect
          .map((e) => DropdownMenuEntry(
                value: e,
                label: e,
              ))
          .toList(),
      onSelected: (branch) => context
          .read<BatchOperateBloc>()
          .add(BatchOperateSelectBranchEvent(branchName: branch ?? '')),
    );
  }

  Widget _buildBranchName(BuildContext context, BatchOperateState state) {
    return TextFormField(
      controller: context.read<BatchOperateBloc>().targetNameController,
      onChanged: (t) => context
          .read<BatchOperateBloc>()
          .add(BatchOperateCreateBranchEvent(branchName: t)),
      decoration: const InputDecoration(
        labelText: 'branch名字', // 标签
        hintText: 'branch名字', // 提示文本
        border: OutlineInputBorder(), // 设置边框样式
      ),
    );
  }

  Widget _buildTagName(BuildContext context, BatchOperateState state) {
    return TextFormField(
      controller: context.read<BatchOperateBloc>().targetNameController,
      onChanged: (t) => context
          .read<BatchOperateBloc>()
          .add(BatchOperateCreateTagEvent(tagName: t)),
      decoration: const InputDecoration(
        labelText: 'tag名字', // 标签
        hintText: 'tag名字', // 提示文本
        border: OutlineInputBorder(), // 设置边框样式
      ),
    );
  }
}
