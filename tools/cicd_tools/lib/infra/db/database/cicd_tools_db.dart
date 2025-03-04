import 'dart:async';

import 'package:cicd_tools/infra/db/dao/pipeline_record_dao.dart';
import 'package:platform_utils/platform_storage.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../po/pipeline_record_po.dart';

part 'cicd_tools_db.g.dart'; // the generated code will be there

late CICDToolsDatabase cicdToolsDatabase;

@Database(version: 1, entities: [PipelineRecordPo])
abstract class CICDToolsDatabase extends FloorDatabase {
  PipelineRecordDao get recordDao;
}

// create migration
// final migration1to2 = Migration(1, 2, (database) async {
//   await database.execute('CREATE TABLE workspace (workspace_name TExT PRIMARY KEY, workspace_dir TEXT)');
// });
