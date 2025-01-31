import 'package:code_tools/domain/factory/project_factory.dart';
import 'package:code_tools/domain/usecases/project_usecase.dart';
import 'package:code_tools/infra/datasource/project_data_source.dart';
import 'package:code_tools/infra/repo/project_repo_impl.dart';
import 'package:code_tools/screens/code_repo_management/code_repo_management_bloc.dart';
import 'package:code_tools/screens/code_repo_management/widgets/code_repo_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_screenutils.dart';
import 'package:platform_utils/platform_utils.dart';

import '../../domain/entities/git_action.dart';
import 'code_repo_management_event.dart';
import 'code_repo_management_state.dart';
import 'widgets/code_repo_operation_widget.dart';

class CodeRepoMgmtScreen extends StatelessWidget {
  final String projectName;

  const CodeRepoMgmtScreen({required this.projectName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('仓库管理'),
        actions: [
          InkWell(
            child: const Icon(Icons.settings),
            onTap: () {
              toastHelper.showToast(msg: 'Proxy等设置');
            },
          ),
        ],
      ),
      body: _BodyWidget(projectName),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  final String projectName;

  const _BodyWidget(this.projectName);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CodeRepoMgmtBloc(
          projectName: projectName,
          projectUseCase: ProjectUseCase(
              repo: ProjectRepoImpl(localDataSource: ProjectLocalDataSource()),
              projectFactory: ProjectFactoryImpl()))
        ..add(CodeRepoMgmtInitEvent()),
      child: BlocConsumer<CodeRepoMgmtBloc, CodeRepoMgmtState>(
          builder: (context, state) {
            final List<CodeRepoOperationItemState> items = [
              CodeRepoOperationItemState(
                  text: 'Checkout',
                  onTap: () {
                    context.read<CodeRepoMgmtBloc>().add(CodeRepoOperationEvent(
                        context: context,
                        operation: CodeRepoOperation.checkout));
                  }),
              CodeRepoOperationItemState(
                  text: 'Pull',
                  onTap: () {
                    context.read<CodeRepoMgmtBloc>().add(CodeRepoOperationEvent(
                        context: context, operation: CodeRepoOperation.pull));
                  }),
              CodeRepoOperationItemState(
                  text: 'TAG',
                  onTap: () {
                    context.read<CodeRepoMgmtBloc>().add(CodeRepoOperationEvent(
                        context: context, operation: CodeRepoOperation.tag));
                  }),
              CodeRepoOperationItemState(
                  text: 'Create Branch',
                  onTap: () {
                    context.read<CodeRepoMgmtBloc>().add(CodeRepoOperationEvent(
                        context: context, operation: CodeRepoOperation.branch));
                  }),
              CodeRepoOperationItemState(
                  text: 'Publish(Todo)',
                  onTap: () {
                    context.read<CodeRepoMgmtBloc>().add(CodeRepoOperationEvent(
                        context: context,
                        operation: CodeRepoOperation.publish));
                  }),
              CodeRepoOperationItemState(
                  text: 'Code统计(Todo)',
                  onTap: () {
                    context.read<CodeRepoMgmtBloc>().add(CodeRepoOperationEvent(
                        context: context,
                        operation: CodeRepoOperation.codeStatistic));
                  }),
              CodeRepoOperationItemState(
                  text: '依赖关系(Todo)',
                  onTap: () {
                    context.read<CodeRepoMgmtBloc>().add(CodeRepoOperationEvent(
                        context: context,
                        operation: CodeRepoOperation.repoDependencies));
                  }),
            ];

            return Column(
              children: [
                CodeRepoOperationsWidget(
                  items: items,
                ),
                SizedBox(
                  height: 8.h,
                ),
                _buildCodeReposList(context, state),
              ],
            );
          },
          listener: (c, s) {}),
    );
  }

  Widget _buildCodeReposList(BuildContext context, CodeRepoMgmtState state) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var codeRepo = state.codeRepoEntities[index];
            return CodeRepoItemWidget(
              codeRepo,
              deleteCallback: () {
                context.read<CodeRepoMgmtBloc>().add(
                    CodeRepoDeleteEvent(codeRepoName: codeRepo.codeRepoName));
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 16.h,
            );
          },
          itemCount: state.codeRepoEntities.length),
    );
  }
}
