import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  // Private static instance
  static Database? _database;

  // Version management - increase this when changing schema
  static const int _databaseVersion = 2;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'transactions_database.db');

      _database = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: (db, version) async {
          await _createTables(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          await _handleMigrations(db, oldVersion, newVersion);
        },
        // optional: onDowngrade for debug only
        onDowngrade: kDebugMode ? (db, oldV, newV) async {} : null,
      );

      debugPrint('✓ Database initialized successfully (v$_databaseVersion)');
      return _database!;
    } catch (e, stack) {
      debugPrint('Database initialization failed: $e');
      debugPrint(stack.toString());
      rethrow;
    }
  }

  static Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        category TEXT NOT NULL,
        type TEXT NOT NULL CHECK(type IN ('expense', 'income')),
        icon TEXT,
        notes TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  static Future<void> _handleMigrations(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // Example future migration
      await db.execute('ALTER TABLE transactions ADD COLUMN notes TEXT;');
    }
    // Add more conditions as needed when you bump version
  }

  // Close database when app terminates (optional but good practice)
  static Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
      debugPrint('Database closed');
    }
  }

  // Improved debug test with proper ID
  static Future<void> debugTest() async {
    final db = await database;

    const testId = 'debug_test_001';

    await db.insert('transactions', {
      'id': testId,
      'amount': 123.45,
      'date': DateTime.now().toIso8601String(),
      'category': 'Debug Test',
      'type': 'expense',
      'icon': 'money_off',
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    debugPrint('Inserted test row with id: $testId');

    final rows = await db.query(
      'transactions',
      where: 'id = ?',
      whereArgs: [testId],
    );

    debugPrint('Found test row: $rows');
  }
}
