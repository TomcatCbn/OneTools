sealed class CodeRepoMgmtEvent {}

/// 初始化
class CodeRepoMgmtInitEvent extends CodeRepoMgmtEvent {}

/// 仓库操作
class CodeRepoOperationEvent extends CodeRepoMgmtEvent {
  final String operation;

  CodeRepoOperationEvent({required this.operation});
}
