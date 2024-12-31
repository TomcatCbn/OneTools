import 'package:code_tools/domain/factory/project_factory.dart';
import 'package:code_tools/domain/usecases/project_usecase.dart';
import 'package:code_tools/infra/datasource/project_data_source.dart';
import 'package:code_tools/infra/repo/project_repo_impl.dart';
import 'package:code_tools/screens/home/home_bloc.dart';
import 'package:code_tools/screens/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_utils.dart';
import 'package:platform_utils/platform_screenutils.dart';

import 'home_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Project 管理'),
      ),
      body: _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
          projectUseCase: ProjectUseCase(
              repo: ProjectRepoImpl(localDataSource: ProjectLocalDataSource()),
              projectFactory: ProjectFactoryImpl()))
        ..add(HomeInitEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
          builder: (builderContext, state) {
            return buildContent(builderContext, state);
          },
          listener: (context, state) {}),
    );
  }

  Widget buildContent(BuildContext context, HomeState state) {
    Widget content;
    // 无内容
    if (state.projects.isEmpty) {
      content = const Center(child: Text('No Projects'));
    } else {
      // 有project
      content = ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final project = state.projects[index];
          return InkWell(
            onTap: () {
              context.read<HomeBloc>().add(HomeClickProjectEvent(
                  projectName: project.projectName, context: context));
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: Column(children: [
                    Text(project.projectName,style: TextStyle(fontSize: 12.0.sp),),
                    Text('Desc: ${project.projectDesc}'),
                    Text('ProjectDir: ${project.projectDir}'),
                    Text('CodeRepo count: ${project.codeRepoCount}')
                  ]),
                ),
              ),
            ),
          );
        },
        itemCount: state.projects.length,
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
          context.read<HomeBloc>().add(HomeCreateProjectByJsonFileEvent());
        },
        child: const Icon(Icons.add),
      ),
    );
    return Stack(
      children: [content, addWidget],
    );
  }
}
