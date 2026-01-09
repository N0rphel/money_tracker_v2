import 'package:flutter/material.dart';
import 'package:money_tracker_v2/data/database.dart';
import 'package:path/path.dart';
import 'package:money_tracker_v2/modals/transaction.dart';
import 'package:sqflite/sqflite.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  // Load all transactions
  Future<void> loadTransactions() async {
    final db = AppDatabase.db;
    final data = await db.query('transactions', orderBy: 'date DESC');

    _transactions = data.map((e) {
      return TransactionModel(
        id: e['id'] as String,
        amount: (e['amount'] as num).toDouble(),
        date: DateTime.parse(e['date'] as String),
        category: e['category'] as String,
        type: e['type'] as String,
      );
    }).toList();

    notifyListeners();
  }

  Future<void> deleteOldDatabase() async {
    final path = join(await getDatabasesPath(), 'transactions_database.db');
    await deleteDatabase(path);
    print('Old database deleted.');
  }

  // Add a transaction
  Future<void> addTransaction(TransactionModel tx) async {
    final db = AppDatabase.db;
    await db.insert('transactions', {
      'id': tx.id,
      'amount': tx.amount,
      'date': tx.date.toIso8601String(),
      'category': tx.category,
      'type': tx.type,
    });

    await loadTransactions();
  }

  // Delete a transaction
  Future<void> deleteTransaction(String id) async {
    final db = AppDatabase.db;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
    await loadTransactions();
  }
}
