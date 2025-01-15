import 'dart:async';

import 'package:code_tools/infra/db/dao/code_repo_dao.dart';
import 'package:code_tools/infra/db/dao/project_dao.dart';
import 'package:code_tools/infra/db/dao/workspace_dao.dart';
import 'package:platform_utils/platform_storage.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../po/code_repo_po.dart';
import '../po/project_po.dart';
import '../po/workspace_po.dart';

part 'work_space_db.g.dart'; // the generated code will be there

late WorkSpaceDatabase workSpaceDatabase;

@Database(version: 1, entities: [WorkSpacePo])
abstract class WorkSpaceDatabase extends FloorDatabase {
  WorkSpaceDao get workSpaceDao;
}
