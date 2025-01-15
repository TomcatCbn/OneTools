import '../../domain/entities/workspace.dart';

sealed class WorkSpaceHomeEvent {}

/// 初始化
class WorkSpaceHomeInitEvent extends WorkSpaceHomeEvent {}

/// 点击具体的workspace事件
class WorkSpaceClickEvent extends WorkSpaceHomeEvent {
  final WorkSpaceEntity workSpaceEntity;

  WorkSpaceClickEvent({required this.workSpaceEntity});
}

/// 根据选择的文件创建workspace
class WorkSpaceCreateEvent extends WorkSpaceHomeEvent {}

/// 删除
class WorkSpaceDeleteEvent extends WorkSpaceHomeEvent {
  final WorkSpaceEntity workSpaceEntity;

  WorkSpaceDeleteEvent({required this.workSpaceEntity});
}
