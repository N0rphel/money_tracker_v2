class TransactionModel {
  final String id;
  final double amount;
  final DateTime date;
  final String category;
  final String type;
  final String? icon;
  final String? notes;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    this.icon,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
      'type': type,
      'icon': icon,
      'notes': notes,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
      category: map['category'] as String,
      type: map['type'] as String,
      icon: map['icon'] as String?,
      notes: map['notes'] as String?,
    );
  }
}
