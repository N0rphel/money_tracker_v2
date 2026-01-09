import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<void> init() async {
    if (_db != null) return;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'transactions_database.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transactions (
            id TEXT PRIMARY KEY,
            amount REAL,
            date TEXT,
            category TEXT,
            type TEXT
          )
        ''');
      },
    );
  }

  static Database get db => _db!;

  static Future<void> debugTest() async {
    final db = AppDatabase.db;

    // insert
    final id = await db.insert('transactions', {
      'amount': 123.45,
      'date': DateTime.now().toIso8601String(),
      'category': 'Test',
      'type': 'expense',
    });

    debugPrint('Inserted row id: $id');

    // read
    final rows = await db.query('transactions');
    debugPrint('Rows in DB: $rows');
  }
}
