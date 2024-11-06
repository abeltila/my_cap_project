part of 'index.dart';

// This service will not have any knowledge about the specific structure of the models,
// keeping it a pure CRUD service. It's a generic implementation of a high level abstaction
// from the specfic implemntation of the sql database. This way when ever we decide to
// change the package we can without husl
abstract class BaseDatabaseService<T> {
  Future<void> insert({
    required T item,
    required String tableName,
    required Map<String, dynamic> Function(T) toMap,
  });

  Future<List<T?>> getAll({
    required String tableName,
    required T Function(Map<String, dynamic>) fromMap,
  });

  Future<T?> getById({
    required String tableName,
    required int id,
    required T Function(Map<String, dynamic>) fromMap,
  });

  Future<void> update({
    required T item,
    required String tableName,
    required Map<String, dynamic> Function(T) toMap,
  });
}

// Implementation of BaseDatabaseService using sqflite
class SqlDatabaseService<T> implements BaseDatabaseService<T> {
  Database? _database;

  SqlDatabaseService();

  // Get the database instance or initialize it if null
  Future<Database> database({
    required String tableName,
    required String tableKey,
    String? sqlCommand,
  }) async {
    if (_database != null) return _database!;
    _database = await _initDatabase(tableName, tableKey, sqlCommand: sqlCommand);
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase(String tableName, String tableKey, {String? sqlCommand}) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        await db.execute(sqlCommand ?? '''
        CREATE TABLE IF NOT EXISTS $tableName (
          $tableKey
        )
      ''').then((v){
        logger.d('message');
        });
      },
      onCreate: (db, version) {},
    );
  }

  // Insert item into specified table
  @override
  Future<void> insert({
    required T item,
    required String tableName,
    required Map<String, dynamic> Function(T) toMap,
  }) async {
    try {
      await _database!.insert(
        tableName,
        toMap(item),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  // Retrieve all items from specified table
  @override
  Future<List<T>> getAll({
    required String tableName,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      if (_database == null) {
        return [];
      }
      final List<Map<String, dynamic>> maps = await _database!.query(tableName);
      return maps.map((map) => fromMap(map)).toList();
    } catch (e) {
      logger.d(e);
      rethrow;
    }
  }

  // Retrieve a single item by ID from specified table
  @override
  Future<T?> getById({
    required String tableName,
    required int id,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    if (_database == null) {
      return null;
    }
    final maps = await _database!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Update an item in the specified table
  @override
  Future<void> update({
    required T item,
    required String tableName,
    required Map<String, dynamic> Function(T) toMap,
  }) async {
    if (_database == null) {
      return;
    }
    final int id = toMap(item)['id'] as int;
    await _database!.update(
      tableName,
      toMap(item),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close the database connection when done
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
