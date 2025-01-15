// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_space_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $WorkSpaceDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $WorkSpaceDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $WorkSpaceDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<WorkSpaceDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorWorkSpaceDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $WorkSpaceDatabaseBuilderContract databaseBuilder(String name) =>
      _$WorkSpaceDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $WorkSpaceDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$WorkSpaceDatabaseBuilder(null);
}

class _$WorkSpaceDatabaseBuilder implements $WorkSpaceDatabaseBuilderContract {
  _$WorkSpaceDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $WorkSpaceDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $WorkSpaceDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<WorkSpaceDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$WorkSpaceDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$WorkSpaceDatabase extends WorkSpaceDatabase {
  _$WorkSpaceDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WorkSpaceDao? _workSpaceDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `workspace` (`workspace_name` TEXT NOT NULL, `workspace_dir` TEXT NOT NULL, PRIMARY KEY (`workspace_name`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WorkSpaceDao get workSpaceDao {
    return _workSpaceDaoInstance ??= _$WorkSpaceDao(database, changeListener);
  }
}

class _$WorkSpaceDao extends WorkSpaceDao {
  _$WorkSpaceDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _workSpacePoInsertionAdapter = InsertionAdapter(
            database,
            'workspace',
            (WorkSpacePo item) => <String, Object?>{
                  'workspace_name': item.workSpaceName,
                  'workspace_dir': item.workSpaceDir
                }),
        _workSpacePoUpdateAdapter = UpdateAdapter(
            database,
            'workspace',
            ['workspace_name'],
            (WorkSpacePo item) => <String, Object?>{
                  'workspace_name': item.workSpaceName,
                  'workspace_dir': item.workSpaceDir
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WorkSpacePo> _workSpacePoInsertionAdapter;

  final UpdateAdapter<WorkSpacePo> _workSpacePoUpdateAdapter;

  @override
  Future<List<WorkSpacePo>> findAllWorkSpace() async {
    return _queryAdapter.queryList('SELECT * FROM workspace',
        mapper: (Map<String, Object?> row) => WorkSpacePo(
            workSpaceName: row['workspace_name'] as String,
            workSpaceDir: row['workspace_dir'] as String));
  }

  @override
  Future<WorkSpacePo?> findCodeRepoBy(String workSpaceName) async {
    return _queryAdapter.query(
        'SELECT * FROM workspace WHERE workspace_name = ?1',
        mapper: (Map<String, Object?> row) => WorkSpacePo(
            workSpaceName: row['workspace_name'] as String,
            workSpaceDir: row['workspace_dir'] as String),
        arguments: [workSpaceName]);
  }

  @override
  Future<void> deleteWorkSpaceBy(String workSpaceName) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM workspace WHERE workspace_name = ?1',
        arguments: [workSpaceName]);
  }

  @override
  Future<void> insertWorkSpace(WorkSpacePo workSpace) async {
    await _workSpacePoInsertionAdapter.insert(
        workSpace, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateWorkSpace(WorkSpacePo codeRepo) async {
    await _workSpacePoUpdateAdapter.update(
        codeRepo, OnConflictStrategy.replace);
  }
}
