import 'package:flutter/material.dart';

sealed class HomeEvent {}

/// 初始化
class HomeInitEvent extends HomeEvent {}

/// 点击具体的project事件
class HomeClickProjectEvent extends HomeEvent {
  final String projectName;
  final BuildContext context;

  HomeClickProjectEvent({required this.projectName, required this.context});
}

/// 根据选择的文件创建project
class HomeCreateProjectByJsonFileEvent extends HomeEvent {}
