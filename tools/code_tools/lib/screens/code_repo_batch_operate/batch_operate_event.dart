sealed class BatchOperateEvent {}

class BatchOperateInitEvent extends BatchOperateEvent {}

class BatchOperateConfirmEvent extends BatchOperateEvent {}

class BatchOperateSearchKeyWordEvent extends BatchOperateEvent {
  final String keyWord;

  BatchOperateSearchKeyWordEvent({required this.keyWord});
}

class BatchOperateSelectEvent extends BatchOperateEvent {
  final String codeRepoName;

  BatchOperateSelectEvent({required this.codeRepoName});
}
