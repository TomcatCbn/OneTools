import 'package:code_tools/domain/entities/project.dart';
import 'package:code_tools/infra/db/dao/code_repo_dao.dart';
import 'package:code_tools/infra/db/database/code_tools_db.dart';
import 'package:code_tools/infra/db/po/code_repo_po.dart';
import 'package:code_tools/infra/db/po/project_po.dart';

import '../db/dao/project_dao.dart';

class ProjectLocalDataSource {
  final ProjectDao projectDao = codeToolsDatabase.projectDao;
  final CodeRepoDao codeRepoDao = codeToolsDatabase.codeRepoDao;

  ProjectLocalDataSource();

  Future<bool> addProject(ProjectAggregate project) async {
    await projectDao.insertProject(ProjectPo(
        projectName: project.projectName,
        projectDesc: project.projectDesc,
        workDir: project.workDir));
    await codeRepoDao.insertCodeRepos(project.codeRepos.map((e) {
      return CodeRepoPo(
        repoUrl: e.gitEntity.gitRepo,
        project: project.projectName,
        workDir: e.workDir,
        codeRepoName: e.codeRepoName,
      );
    }).toList());

    return true;
  }

  Future<List<ProjectAggregate>> loadAllProject(String workDir) async {
    if (workDir.isEmpty) {
      return [];
    }
    var pos = await projectDao.findAllProject(workDir);
    var projects = pos.map((e) async {
      var codeRepos = await codeRepoDao.findAllCodeRepoBy(
          e.projectName, '$workDir/${e.projectName}');
      return ProjectAggregate.fromDb(
          projectName: e.projectName,
          projectDesc: e.projectDesc,
          workDir: e.workDir,
          codeRepoList: codeRepos.map((e) => e.toDo()).toList());
    }).toList();
    var wait = await Future.wait(projects);
    return wait;
  }

  Future<ProjectAggregate?> loadProject(
      String projectName, String workDir) async {
    var po = await projectDao.findProjectBy(projectName, workDir);
    if (po == null) {
      return null;
    }

    var codeRepos = await codeRepoDao.findAllCodeRepoBy(
        projectName, '${po.workDir}/${po.projectName}');

    return ProjectAggregate.fromDb(
        projectName: po.projectName,
        projectDesc: po.projectDesc,
        workDir: po.workDir,
        codeRepoList: codeRepos.map((e) => e.toDo()).toList());
  }

  Future<bool> removeProject(ProjectAggregate project) async {
    await projectDao.deleteProject(ProjectPo(
        projectName: project.projectName,
        projectDesc: project.projectDesc,
        workDir: project.workDir));
    project.codeRepos.map((e) {
      codeRepoDao.deleteCodeRepo(CodeRepoPo(
        repoUrl: e.gitEntity.gitRepo,
        project: project.projectName,
        workDir: e.workDir,
        codeRepoName: e.codeRepoName,
      ));
    });

    return true;
  }

  Future<bool> updateProject(ProjectAggregate project) async {
    await projectDao.updateProject(ProjectPo(
        projectName: project.projectName,
        projectDesc: project.projectDesc,
        workDir: project.workDir));
    var map = project.codeRepos.map((e) async {
      var codeRepoPo = await codeRepoDao.findCodeRepoBy(e.gitEntity.gitRepo);
      bool exist = codeRepoPo != null;
      if (exist) {
        await codeRepoDao.updateCodeRepo(CodeRepoPo(
          repoUrl: e.gitEntity.gitRepo,
          project: project.projectName,
          workDir: e.workDir,
          codeRepoName: e.codeRepoName,
        ));
      } else {
        await codeRepoDao.insertCodeRepo(CodeRepoPo(
          repoUrl: e.gitEntity.gitRepo,
          project: project.projectName,
          workDir: e.workDir,
          codeRepoName: e.codeRepoName,
        ));
      }
    });
    await Future.wait(map);
    return true;
  }

  Future<bool> isProjectExist(String projectName, String workDir) async {
    var projectPo = await projectDao.findProjectBy(projectName, workDir);
    return projectPo != null;
  }

  Future<bool> removeCodeRepo(String codeRepoName) async {
    await codeRepoDao.deleteCodeRepoBy(codeRepoName);
    return true;
  }
}
