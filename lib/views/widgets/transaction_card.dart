import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_tracker_v2/modals/transaction.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == 'income';
    final color = isIncome ? Colors.green : Colors.red;

    return Slidable(
      key: ValueKey(transaction.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio:
            0.35, // how much to reveal (35% of width → two buttons nicely)
        children: [
          // Edit action
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            autoClose: true,
          ),

          // Delete action
          SlidableAction(
            onPressed: (_) {
              // Optional: add confirmation here
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete?'),
                  content: const Text('This cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                        onDelete();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            autoClose: true,
          ),
        ],
      ),

      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Your existing icon, category, amount, notes...
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    parseIconFromString(transaction.icon),
                    size: 32,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.category,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (transaction.notes?.isNotEmpty ?? false) ...[
                        const SizedBox(height: 4),
                        Text(
                          transaction.notes!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${isIncome ? '+ ' : '- '}Nu. ${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData parseIconFromString(String? iconString) {
    if (iconString == null || iconString.isEmpty) {
      return Icons.monetization_on; // fallback
    }

    final hexMatch = RegExp(r'U\+([0-9a-fA-F]+)').firstMatch(iconString);
    if (hexMatch == null) {
      return Icons.question_mark;
    }

    final hexCode = hexMatch.group(1)!;
    final codePoint = int.parse(hexCode, radix: 16);

    return IconData(codePoint, fontFamily: 'MaterialIcons', fontPackage: null);
  }
}
