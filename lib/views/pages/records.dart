import 'package:flutter/material.dart';
import 'package:money_tracker_v2/data/transaction_provider.dart';
import 'package:money_tracker_v2/views/widgets/card_header.dart';
import 'package:money_tracker_v2/views/widgets/record_appbar.dart';
import 'package:money_tracker_v2/views/widgets/transaction_card.dart';
import 'package:provider/provider.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(102),
        child: RecordAppbar(),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Text(
                'Error: ${provider.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (provider.transactions.isEmpty) {
            return const Center(child: Text('No transactions yet. Add some!'));
          }

          return ListView.builder(
            itemCount: provider.transactions.length,
            itemBuilder: (context, index) {
              final tx = provider.transactions[index];

              return TransactionCard(
                icon: _getIconFromString(tx.icon), // helper function below
                category: tx.category,
                type: tx.type,
                amount: tx.amount,
              );
            },
          );
        },
      ),
    );
  }

  IconData _getIconFromString(String? iconString) {
    // Example: if icon is stored as "monetization_on" or codePoint
    if (iconString == null || iconString.isEmpty) {
      return Icons.monetization_on;
    }
    // More advanced: if you store icon name or code point
    return Icons.monetization_on; // fallback
  }
}
