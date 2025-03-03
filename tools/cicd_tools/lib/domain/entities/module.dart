
// 模块，在应用中有n个模块
import 'git_action.dart';
import 'repo.dart';

class ModuleEntity with GitAction {
  final RepoEntity repo;
  final String moduleName;

  String targetBranch = 'develop';

  ModuleEntity({required this.repo, required this.moduleName});
}
