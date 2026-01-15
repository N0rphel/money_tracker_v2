import 'package:money_tracker_v2/modals/transaction.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  final Database db;

  TransactionRepository(this.db);

  Future<List<TransactionModel>> getAllTransactions() async {
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      orderBy: 'date DESC',
    );

    return List.generate(maps.length, (i) {
      return TransactionModel.fromMap(maps[i]);
    });
  }

  Future<void> insertTransaction(TransactionModel transaction) async {
    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id=?',
      whereArgs: [transaction.id],
    );
  }

  Future<void> deleteTransaction(String id) async {
    await db.delete('transactions', where: 'id=?', whereArgs: [id]);
  }
}
