import 'package:flutter/material.dart';

import '../../domain/entities/git_action.dart';

sealed class CodeRepoMgmtEvent {}

/// 初始化
class CodeRepoMgmtInitEvent extends CodeRepoMgmtEvent {}

/// 仓库操作
class CodeRepoOperationEvent extends CodeRepoMgmtEvent {
  final CodeRepoOperation operation;
  final BuildContext context;

  CodeRepoOperationEvent({required this.context, required this.operation});
}

/// 删除仓库
class CodeRepoDeleteEvent extends CodeRepoMgmtEvent {
  final String codeRepoName;

  CodeRepoDeleteEvent({required this.codeRepoName});
}
