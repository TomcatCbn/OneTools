
// 模块，在应用中有n个模块
import 'package:cicd_tools/domain/entities/gradle_action.dart';

import 'git_action.dart';
import 'repo.dart';

class ModuleEntity with GitAction, GradleAction {
  final RepoEntity repo;
  final String moduleName;

  String targetBranch = 'develop';

  String targetTag = '';

  final List<String> dependencyModules = [];

  ModuleEntity({required this.repo, required this.moduleName});
}
