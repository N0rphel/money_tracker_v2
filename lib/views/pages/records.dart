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
      body: CustomScrollView(
        slivers: [
          Consumer<TransactionProvider>(
            builder: (context, provider, _) {
              final grouped = provider.getDailyGroupedTransactions();
              final dates = grouped.keys.toList();

              if (provider.isLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (dates.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No transactions yet this month',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildListDelegate([
                  for (final date in dates) ...[
                    DayHeader(date: date),
                    ...grouped[date]!.map(
                      (tx) => TransactionCard(
                        icon: parseIconFromString(tx.icon),
                        category: tx.category,
                        type: tx.type,
                        amount: tx.amount,
                      ),
                    ),
                    const Divider(height: 24),
                  ],
                ]),
              );
            },
          ),
        ],
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
