class TransactionModel {
  final String id;
  final double amount;
  final DateTime date;
  final String category;
  final String type;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
  });
}
