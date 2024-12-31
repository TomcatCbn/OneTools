// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_tools_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $CodeToolsDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $CodeToolsDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $CodeToolsDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<CodeToolsDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorCodeToolsDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $CodeToolsDatabaseBuilderContract databaseBuilder(String name) =>
      _$CodeToolsDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $CodeToolsDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$CodeToolsDatabaseBuilder(null);
}

class _$CodeToolsDatabaseBuilder implements $CodeToolsDatabaseBuilderContract {
  _$CodeToolsDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $CodeToolsDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $CodeToolsDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<CodeToolsDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$CodeToolsDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$CodeToolsDatabase extends CodeToolsDatabase {
  _$CodeToolsDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProjectDao? _projectDaoInstance;

  CodeRepoDao? _codeRepoDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `project` (`project_name` TEXT NOT NULL, `project_desc` TEXT NOT NULL, `work_dir` TEXT NOT NULL, PRIMARY KEY (`project_name`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `code_repo` (`code_repo_name` TEXT NOT NULL, `repo_url` TEXT NOT NULL, `work_dir` TEXT NOT NULL, `project` TEXT NOT NULL, FOREIGN KEY (`project`) REFERENCES `project` (`project_name`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`repo_url`))');
        await database.execute(
            'CREATE INDEX `index_project_project_name` ON `project` (`project_name`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProjectDao get projectDao {
    return _projectDaoInstance ??= _$ProjectDao(database, changeListener);
  }

  @override
  CodeRepoDao get codeRepoDao {
    return _codeRepoDaoInstance ??= _$CodeRepoDao(database, changeListener);
  }
}

class _$ProjectDao extends ProjectDao {
  _$ProjectDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _projectPoInsertionAdapter = InsertionAdapter(
            database,
            'project',
            (ProjectPo item) => <String, Object?>{
                  'project_name': item.projectName,
                  'project_desc': item.projectDesc,
                  'work_dir': item.workDir
                }),
        _projectPoUpdateAdapter = UpdateAdapter(
            database,
            'project',
            ['project_name'],
            (ProjectPo item) => <String, Object?>{
                  'project_name': item.projectName,
                  'project_desc': item.projectDesc,
                  'work_dir': item.workDir
                }),
        _projectPoDeletionAdapter = DeletionAdapter(
            database,
            'project',
            ['project_name'],
            (ProjectPo item) => <String, Object?>{
                  'project_name': item.projectName,
                  'project_desc': item.projectDesc,
                  'work_dir': item.workDir
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProjectPo> _projectPoInsertionAdapter;

  final UpdateAdapter<ProjectPo> _projectPoUpdateAdapter;

  final DeletionAdapter<ProjectPo> _projectPoDeletionAdapter;

  @override
  Future<List<ProjectPo>> findAllProject() async {
    return _queryAdapter.queryList('SELECT * FROM project',
        mapper: (Map<String, Object?> row) => ProjectPo(
            projectName: row['project_name'] as String,
            projectDesc: row['project_desc'] as String,
            workDir: row['work_dir'] as String));
  }

  @override
  Future<ProjectPo?> findProjectBy(String projectName) async {
    return _queryAdapter.query('SELECT * FROM project WHERE project_name = ?1',
        mapper: (Map<String, Object?> row) => ProjectPo(
            projectName: row['project_name'] as String,
            projectDesc: row['project_desc'] as String,
            workDir: row['work_dir'] as String),
        arguments: [projectName]);
  }

  @override
  Future<void> insertProject(ProjectPo project) async {
    await _projectPoInsertionAdapter.insert(project, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProject(ProjectPo project) async {
    await _projectPoUpdateAdapter.update(project, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteProject(ProjectPo project) async {
    await _projectPoDeletionAdapter.delete(project);
  }
}

class _$CodeRepoDao extends CodeRepoDao {
  _$CodeRepoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _codeRepoPoInsertionAdapter = InsertionAdapter(
            database,
            'code_repo',
            (CodeRepoPo item) => <String, Object?>{
                  'code_repo_name': item.codeRepoName,
                  'repo_url': item.repoUrl,
                  'work_dir': item.workDir,
                  'project': item.project
                }),
        _codeRepoPoUpdateAdapter = UpdateAdapter(
            database,
            'code_repo',
            ['repo_url'],
            (CodeRepoPo item) => <String, Object?>{
                  'code_repo_name': item.codeRepoName,
                  'repo_url': item.repoUrl,
                  'work_dir': item.workDir,
                  'project': item.project
                }),
        _codeRepoPoDeletionAdapter = DeletionAdapter(
            database,
            'code_repo',
            ['repo_url'],
            (CodeRepoPo item) => <String, Object?>{
                  'code_repo_name': item.codeRepoName,
                  'repo_url': item.repoUrl,
                  'work_dir': item.workDir,
                  'project': item.project
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CodeRepoPo> _codeRepoPoInsertionAdapter;

  final UpdateAdapter<CodeRepoPo> _codeRepoPoUpdateAdapter;

  final DeletionAdapter<CodeRepoPo> _codeRepoPoDeletionAdapter;

  @override
  Future<List<CodeRepoPo>> findAllCodeRepo() async {
    return _queryAdapter.queryList('SELECT * FROM code_repo',
        mapper: (Map<String, Object?> row) => CodeRepoPo(
            codeRepoName: row['code_repo_name'] as String,
            repoUrl: row['repo_url'] as String,
            workDir: row['work_dir'] as String,
            project: row['project'] as String));
  }

  @override
  Future<CodeRepoPo?> findCodeRepoBy(String repoUrl) async {
    return _queryAdapter.query('SELECT * FROM code_repo WHERE repo_url = ?1',
        mapper: (Map<String, Object?> row) => CodeRepoPo(
            codeRepoName: row['code_repo_name'] as String,
            repoUrl: row['repo_url'] as String,
            workDir: row['work_dir'] as String,
            project: row['project'] as String),
        arguments: [repoUrl]);
  }

  @override
  Future<List<CodeRepoPo>> findAllCodeRepoBy(String project) async {
    return _queryAdapter.queryList('SELECT * FROM code_repo WHERE project = ?1',
        mapper: (Map<String, Object?> row) => CodeRepoPo(
            codeRepoName: row['code_repo_name'] as String,
            repoUrl: row['repo_url'] as String,
            workDir: row['work_dir'] as String,
            project: row['project'] as String),
        arguments: [project]);
  }

  @override
  Future<void> deleteCodeRepoBy(String codeRepoName) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM code_repo WHERE code_repo_name = ?1',
        arguments: [codeRepoName]);
  }

  @override
  Future<void> insertCodeRepo(CodeRepoPo codeRepo) async {
    await _codeRepoPoInsertionAdapter.insert(
        codeRepo, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertCodeRepos(List<CodeRepoPo> codeRepos) async {
    await _codeRepoPoInsertionAdapter.insertList(
        codeRepos, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCodeRepo(CodeRepoPo codeRepo) async {
    await _codeRepoPoUpdateAdapter.update(codeRepo, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteCodeRepo(CodeRepoPo codeRepo) async {
    await _codeRepoPoDeletionAdapter.delete(codeRepo);
  }
}
