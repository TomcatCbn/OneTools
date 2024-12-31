enum CodeRepoOperation {
  /// 切换分支
  checkout,

  /// 创建分支
  branch,

  /// 拉取代码
  pull,

  /// 打tag
  tag,

  /// 仓库发布
  publish,

  /// 代码统计
  codeStatistic,

  /// 模块依赖关系
  repoDependencies,
}
