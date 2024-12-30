sealed class CodeRepoMgmtEvent {}

/// 初始化
class CodeRepoMgmtInitEvent extends CodeRepoMgmtEvent {}

/// 仓库操作
class CodeRepoOperationEvent extends CodeRepoMgmtEvent {
  final String operation;

  CodeRepoOperationEvent({required this.operation});
}

/// 删除仓库
class CodeRepoDeleteEvent extends CodeRepoMgmtEvent {
  final String codeRepoName;

  CodeRepoDeleteEvent({required this.codeRepoName});
}
