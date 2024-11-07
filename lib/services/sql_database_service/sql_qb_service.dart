part of 'index.dart';

// This service will not have any knowledge about the specific structure of the models,
// keeping it a pure CRUD service. It's a generic implementation of a high level abstraction
// from the specific implementation of the sql database. This way when ever we decide to
// change the package we can without husl
/// Abstract base class for database operations, supporting CRUD operations.
abstract class BaseDatabaseService<T> {
  /// Inserts an [item] into the specified [tableName].
  ///
  /// [toMap] converts the item of type [T] to a [Map] representation.
  Future<void> insert({
    required T item,
    required String tableName,
    required Map<String, dynamic> Function(T) toMap,
  });

  /// Retrieves all items from the specified [tableName].
  ///
  /// [fromMap] converts a [Map] representation back to an item of type [T].
  Future<List<T?>> getAll({
    required String tableName,
    required T Function(Map<String, dynamic>) fromMap,
  });

  /// Retrieves a single item by its [id] from the specified [tableName].
  ///
  /// [fromMap] converts a [Map] representation back to an item of type [T].
  Future<T?> getById({
    required String tableName,
    required int id,
    required T Function(Map<String, dynamic>) fromMap,
  });

  /// Updates an [item] in the specified [tableName].
  ///
  /// [toMap] converts the item of type [T] to a [Map] representation.
  Future<void> update({
    required T item,
    required String tableName,
    required Map<String, dynamic> Function(T) toMap,
  });
}

/// Implementation of [BaseDatabaseService] using sqflite for SQLite operations.
class SqlDatabaseService<T> implements BaseDatabaseService<T> {
  Database? _database;

  SqlDatabaseService();

  /// Retrieves the database instance or initializes it if it’s null.
  ///
  /// [tableName] and [tableKey] are required for database schema definition.
  /// Optional [sqlCommand] allows custom SQL for table creation if needed.
  Future<Database> database({
    required String tableName,
    required String tableKey,
    String? sqlCommand,
  }) async {
    if (_database != null) return _database!;
    _database = await _initDatabase(tableName, tableKey, sqlCommand: sqlCommand);
    return _database!;
  }

  /// Initializes the database and creates the specified table if it does not exist.
  ///
  /// [tableName] defines the name of the table, and [tableKey] specifies the primary key.
  /// Optional [sqlCommand] allows for custom table creation SQL.
  Future<Database> _initDatabase(String tableName, String tableKey, {String? sqlCommand}) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        // Execute SQL to create the table if it doesn't exist.
        await db.execute(sqlCommand ?? '''
        CREATE TABLE IF NOT EXISTS $tableName (
          $tableKey
        )
      ''').then((v) {
          logger.d('Database table $tableName opened or created successfully.');
        });
      },
      onCreate: (db, version) {},
    );
  }

  /// Inserts an [item] into the specified [tableName].
  ///
  /// Converts [item] to a [Map] representation using [toMap].
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

  /// Retrieves all items from the specified [tableName].
  ///
  /// Converts each retrieved [Map] to type [T] using [fromMap].
  /// Returns an empty list if the database is not initialized.
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

  /// Retrieves a single item by its [id] from the specified [tableName].
  ///
  /// Converts the retrieved [Map] to type [T] using [fromMap] if the item exists.
  /// Returns null if no matching item is found.
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

  /// Updates an [item] in the specified [tableName].
  ///
  /// Converts [item] to a [Map] representation using [toMap].
  /// Updates the entry identified by the item's ID.
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

  /// Closes the database connection.
  ///
  /// Sets [_database] to null after closing to allow reinitialization if needed.
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
