import 'package:flutter/material.dart';
import 'package:money_tracker_v2/data/transaction_provider.dart';
import 'package:money_tracker_v2/modals/transaction.dart';
import 'package:provider/provider.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;

  const EditTransactionScreen({super.key, required this.transaction});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  late TextEditingController _amountController;
  late TextEditingController _notesController;
  // Add other controllers (category, type, etc.)

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.transaction.amount.toString(),
    );
    _notesController = TextEditingController(
      text: widget.transaction.notes ?? '',
    );
    // init others...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Create updated transaction
              final updated = widget.transaction.copyWith(
                amount:
                    double.tryParse(_amountController.text) ??
                    widget.transaction.amount,
                notes: _notesController.text,
                // update other fields...
              );

              Provider.of<TransactionProvider>(
                context,
                listen: false,
              ).updateTransaction(updated);

              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            // Add more fields: category picker, type switch, date picker, etc.
          ],
        ),
      ),
    );
  }
}
