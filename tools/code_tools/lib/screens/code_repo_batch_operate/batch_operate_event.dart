sealed class BatchOperateEvent {}

class BatchOperateInitEvent extends BatchOperateEvent {}

class BatchOperateSelectBranchEvent extends BatchOperateEvent {
  final String branchName;

  BatchOperateSelectBranchEvent({required this.branchName});
}

class BatchOperateCreateBranchEvent extends BatchOperateEvent {
  final String branchName;

  BatchOperateCreateBranchEvent({required this.branchName});
}

class BatchOperateCreateTagEvent extends BatchOperateEvent {
  final String tagName;

  BatchOperateCreateTagEvent({required this.tagName});
}

class BatchOperateConfirmEvent extends BatchOperateEvent {}
class BatchOperateAllSelectEvent extends BatchOperateEvent {
  final bool allSelected;

  BatchOperateAllSelectEvent({required this.allSelected});
}

class BatchOperateSearchKeyWordEvent extends BatchOperateEvent {
  final String keyWord;

  BatchOperateSearchKeyWordEvent({required this.keyWord});
}

class BatchOperateSelectEvent extends BatchOperateEvent {
  final String codeRepoName;

  BatchOperateSelectEvent({required this.codeRepoName});
}
