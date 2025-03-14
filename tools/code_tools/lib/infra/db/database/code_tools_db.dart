import 'dart:async';

import 'package:code_tools/infra/db/dao/code_repo_dao.dart';
import 'package:code_tools/infra/db/dao/project_dao.dart';
import 'package:code_tools/infra/db/dao/workspace_dao.dart';
import 'package:platform_utils/platform_storage.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../po/code_repo_po.dart';
import '../po/project_po.dart';
import '../po/workspace_po.dart';

part 'code_tools_db.g.dart'; // the generated code will be there

late CodeToolsDatabase codeToolsDatabase;

@Database(version: 1, entities: [ProjectPo, CodeRepoPo])
abstract class CodeToolsDatabase extends FloorDatabase {
  ProjectDao get projectDao;

  CodeRepoDao get codeRepoDao;
}

// create migration
// final migration1to2 = Migration(1, 2, (database) async {
//   await database.execute('CREATE TABLE workspace (workspace_name TExT PRIMARY KEY, workspace_dir TEXT)');
// });
