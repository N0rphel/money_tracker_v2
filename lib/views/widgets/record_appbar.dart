import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:money_tracker_v2/data/transaction_provider.dart';
import 'package:money_tracker_v2/views/widgets/month_picker.dart';

class RecordAppbar extends StatefulWidget {
  const RecordAppbar({super.key});

  @override
  State<RecordAppbar> createState() => _RecordAppbarState();
}

class _RecordAppbarState extends State<RecordAppbar> {
  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedMonth = now.month;
    selectedYear = now.year;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 105,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Consumer<TransactionProvider>(
          builder: (context, provider, _) {
            final filteredTransactions = provider.transactions.where((tx) {
              return tx.date.month == selectedMonth &&
                  tx.date.year == selectedYear;
            }).toList();

            double totalIncome = 0;
            double totalExpense = 0;

            for (var tx in filteredTransactions) {
              if (tx.type == 'income') {
                totalIncome += tx.amount;
              } else if (tx.type == 'expense') {
                totalExpense += tx.amount.abs();
              }
            }

            final balance = totalIncome - totalExpense;

            final formatter = NumberFormat.currency(
              symbol: 'Nu.',
              decimalDigits: 1,
            );

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Money Tracker',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final result = await showDialog<Map<String, int>>(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: MonthYearPickerSheet(
                                  initialYear: selectedYear,
                                  initialMonth: selectedMonth,
                                ),
                              );
                            },
                          );

                          if (result != null && mounted) {
                            setState(() {
                              selectedMonth = result['month']!;
                              selectedYear = result['year']!;
                            });

                            Provider.of<TransactionProvider>(
                              context,
                              listen: false,
                            ).setSelectedMonthYear(
                              result['year']!,
                              result['month']!,
                            );
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$selectedYear',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimary.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  DateFormat('MMMM').format(
                                    DateTime(selectedYear, selectedMonth),
                                  ),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      _summary(
                        'Expenses',
                        formatter.format(totalExpense),
                        Theme.of(context).colorScheme.error,
                        context,
                      ),
                      const SizedBox(width: 20),
                      _summary(
                        'Income',
                        formatter.format(totalIncome),
                        Theme.of(context).colorScheme.primary,
                        context,
                      ),
                      const SizedBox(width: 20),
                      _summary(
                        'Balance',
                        formatter.format(balance),
                        balance >= 0
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.error,
                        context,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _summary(
    String label,
    String value,
    Color color,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(
              context,
            ).colorScheme.onPrimary.withValues(alpha: 85.0),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}
