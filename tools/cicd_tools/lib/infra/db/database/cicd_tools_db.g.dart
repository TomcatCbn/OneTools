// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cicd_tools_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $CICDToolsDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $CICDToolsDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $CICDToolsDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<CICDToolsDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorCICDToolsDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $CICDToolsDatabaseBuilderContract databaseBuilder(String name) =>
      _$CICDToolsDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $CICDToolsDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$CICDToolsDatabaseBuilder(null);
}

class _$CICDToolsDatabaseBuilder implements $CICDToolsDatabaseBuilderContract {
  _$CICDToolsDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $CICDToolsDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $CICDToolsDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<CICDToolsDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$CICDToolsDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$CICDToolsDatabase extends CICDToolsDatabase {
  _$CICDToolsDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PipelineRecordDao? _recordDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `pipeline_record` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `pipeline_name` TEXT, `create_time` INTEGER, `completed_time` INTEGER, `status` TEXT, `operator` TEXT)');
        await database.execute(
            'CREATE INDEX `index_pipeline_record_pipeline_name_id` ON `pipeline_record` (`pipeline_name`, `id`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PipelineRecordDao get recordDao {
    return _recordDaoInstance ??= _$PipelineRecordDao(database, changeListener);
  }
}

class _$PipelineRecordDao extends PipelineRecordDao {
  _$PipelineRecordDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pipelineRecordPoInsertionAdapter = InsertionAdapter(
            database,
            'pipeline_record',
            (PipelineRecordPo item) => <String, Object?>{
                  'id': item.id,
                  'pipeline_name': item.pipelineName,
                  'create_time': item.createTime,
                  'completed_time': item.completedTime,
                  'status': item.status,
                  'operator': item.operator
                }),
        _pipelineRecordPoUpdateAdapter = UpdateAdapter(
            database,
            'pipeline_record',
            ['id'],
            (PipelineRecordPo item) => <String, Object?>{
                  'id': item.id,
                  'pipeline_name': item.pipelineName,
                  'create_time': item.createTime,
                  'completed_time': item.completedTime,
                  'status': item.status,
                  'operator': item.operator
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PipelineRecordPo> _pipelineRecordPoInsertionAdapter;

  final UpdateAdapter<PipelineRecordPo> _pipelineRecordPoUpdateAdapter;

  @override
  Future<List<PipelineRecordPo>> loadLatestRecords(int latestNum) async {
    return _queryAdapter.queryList(
        'SELECT * FROM pipeline_record ORDER BY id DESC LIMIT ?1',
        mapper: (Map<String, Object?> row) => PipelineRecordPo(
            id: row['id'] as int?,
            pipelineName: row['pipeline_name'] as String?,
            createTime: row['create_time'] as int?,
            status: row['status'] as String?,
            completedTime: row['completed_time'] as int?,
            operator: row['operator'] as String?),
        arguments: [latestNum]);
  }

  @override
  Future<PipelineRecordPo?> findRecordBy(int id) async {
    return _queryAdapter.query('SELECT * FROM pipeline_record WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PipelineRecordPo(
            id: row['id'] as int?,
            pipelineName: row['pipeline_name'] as String?,
            createTime: row['create_time'] as int?,
            status: row['status'] as String?,
            completedTime: row['completed_time'] as int?,
            operator: row['operator'] as String?),
        arguments: [id]);
  }

  @override
  Future<int> insertProject(PipelineRecordPo record) {
    return _pipelineRecordPoInsertionAdapter.insertAndReturnId(
        record, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRecord(PipelineRecordPo record) async {
    await _pipelineRecordPoUpdateAdapter.update(
        record, OnConflictStrategy.replace);
  }
}
