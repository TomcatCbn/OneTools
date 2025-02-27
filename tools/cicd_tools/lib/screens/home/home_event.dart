import 'package:flutter/material.dart';

sealed class HomeEvent {}

/// 初始化
class HomeInitEvent extends HomeEvent {}

/// 点击具体的pipeline事件
class HomeClickPipelineEvent extends HomeEvent {
  final int index;
  final BuildContext context;

  HomeClickPipelineEvent({required this.index, required this.context});
}
