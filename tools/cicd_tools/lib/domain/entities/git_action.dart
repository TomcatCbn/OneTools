import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_logger.dart';

import 'cicd_errors.dart';

/// 赋予git相关的操作
mixin GitAction {
  static const String _tag = 'git-action';

  Future<Either<CICDError, List<String>>> queryBranches(String repo) async {
    var cmd = GitRemoteQueryAllBranch(repo: repo);
    List<String> res = [];
    try {
      var either = await cmd.run();
      res = either.fold(ifLeft: (v) => [], ifRight: (v) => v);
    } catch (e) {
      Logger.e(msg: 'queryBranches failed, $e', tag: _tag);
      return Either.left(CICDRuntimeError(e.toString()));
    }

    return Either.right(res);
  }

  Future<Either<CICDError, List<String>>> queryTags(String repo) async {
    var cmd = GitRemoteQueryAllTAG(repo: repo);
    List<String> res = [];
    try {
      var either = await cmd.run();
      res = either.fold(ifLeft: (v) => [], ifRight: (v) => v);
    } catch (e) {
      Logger.e(msg: 'queryTags failed, $e', tag: _tag);
      return Either.left(CICDRuntimeError(e.toString()));
    }

    return Either.right(res);
  }
}
