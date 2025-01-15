import 'package:code_tools/domain/usecases/workspace_usecase.dart';
import 'package:code_tools/infra/datasource/workspace_data_source.dart';
import 'package:code_tools/infra/repo/workspace_repo_impl.dart';
import 'package:code_tools/screens/settings/settings_screen.dart';
import 'package:code_tools/screens/workspace_home/workspace_home_bloc.dart';
import 'package:code_tools/screens/workspace_home/workspace_home_event.dart';
import 'package:code_tools/screens/workspace_home/workspace_home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:platform_utils/platform_screenutils.dart';
import 'package:platform_utils/platform_utils.dart';

class WorkSpaceHomeScreen extends StatelessWidget {
  const WorkSpaceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('选择你的工作空间'),
        actions: [
          InkWell(
            child: const Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                navigatorKey.currentContext!,
                MaterialPageRoute(builder: (BuildContext context) {
                  return const SettingScreen();
                }),
              );
            },
          )
        ],
      ),
      body: _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkspaceHomeBloc(
          workSpaceUseCase: WorkSpaceUseCase(
              repo: WorkspaceRepoImpl(
                  localDataSource: WorkSpaceLocalDataSource())))
        ..add(WorkSpaceHomeInitEvent()),
      child: BlocConsumer<WorkspaceHomeBloc, WorkspaceHomeState>(
          builder: (builderContext, state) {
            return buildContent(builderContext, state);
          },
          listener: (context, state) {}),
    );
  }

  Widget buildContent(BuildContext context, WorkspaceHomeState state) {
    Widget content;
    // 无内容
    if (state.workspaces.isEmpty) {
      content = const Center(child: Text('No WorkSpace'));
    } else {
      // 有project
      content = ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final workspace = state.workspaces[index];
          return _withSlidable(
              InkWell(
                onTap: () {
                  context
                      .read<WorkspaceHomeBloc>()
                      .add(WorkSpaceClickEvent(workSpaceEntity: workspace));
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Center(
                      child: Column(children: [
                        Text(
                          workspace.workSpaceName,
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                        Text('WorkDir: ${workspace.workSpaceDir}'),
                      ]),
                    ),
                  ),
                ),
              ), () {
            context
                .read<WorkspaceHomeBloc>()
                .add(WorkSpaceDeleteEvent(workSpaceEntity: workspace));
          });
        },
        itemCount: state.workspaces.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 2.h,
        ),
      );
    }

    // 添加project按钮
    final addWidget = Positioned(
      right: 0.1.sw,
      bottom: 0.1.sh,
      child: FloatingActionButton(
        onPressed: () async {
          // 点击展开
          // 1.从本地json加载
          // 2.新增一个project
          context.read<WorkspaceHomeBloc>().add(WorkSpaceCreateEvent());
        },
        child: const Icon(Icons.add),
      ),
    );
    return Stack(
      children: [content, addWidget],
    );
  }

  Widget _withSlidable(Widget child, Function delete) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              delete.call();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: child,
    );
  }
}
