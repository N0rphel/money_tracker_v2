import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final IconData icon;
  final String category;
  final String type;
  final double amount;

  const TransactionCard({
    super.key,
    required this.icon,
    required this.category,
    required this.type,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),

              child: Icon(
                icon,
                size: 38,
                color: type == 'income' ? Colors.green : Colors.red,
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${type == 'income' ? '+ ' : '- '}Nu. ${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: type == 'income' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
