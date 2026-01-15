import 'package:flutter/material.dart';
import 'package:money_tracker_v2/data/transaction_repository.dart';
import 'package:money_tracker_v2/modals/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository _repository;

  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  // Getters
  int get selectedYear => _selectedYear;
  int get selectedMonth => _selectedMonth;

  // Public method to change month/year (called from your AppBar)
  void setSelectedMonthYear(int year, int month) {
    _selectedYear = year;
    _selectedMonth = month;
    notifyListeners(); // ← important! UI will rebuild
  }

  TransactionProvider(this._repository) {
    debugPrint('✅ TransactionProvider CREATED successfully!');
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _transactions = await _repository.getAllTransactions();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.insertTransaction(transaction);
      await loadTransactions(); // refresh the list automatically
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Map<DateTime, List<TransactionModel>> getDailyGroupedTransactions() {
    final Map<DateTime, List<TransactionModel>> grouped = {};

    for (final tx in _transactions) {
      if (tx.date.year == _selectedYear && tx.date.month == _selectedMonth) {
        final dateKey = DateTime(tx.date.year, tx.date.month, tx.date.day);
        grouped.putIfAbsent(dateKey, () => []).add(tx);
      }
    }

    // Sort dates descending (newest first)
    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    final result = <DateTime, List<TransactionModel>>{};
    for (var key in sortedKeys) {
      result[key] = grouped[key]!;
    }

    return result;
  }
}
