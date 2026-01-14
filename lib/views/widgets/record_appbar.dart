import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker_v2/views/widgets/date_picker.dart';
import 'package:provider/provider.dart';
import 'package:money_tracker_v2/data/transaction_provider.dart';

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
    // Initialize with current date (or January 2026 as per your context)
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
          builder: (context, provider, child) {
            // Filter transactions for selected month & year only
            final filteredTransactions = provider.transactions.where((tx) {
              final txDate = tx.date;
              return txDate.month == selectedMonth &&
                  txDate.year == selectedYear;
            }).toList();

            // Calculate totals
            double totalIncome = 0;
            double totalExpense = 0;

            for (var tx in filteredTransactions) {
              if (tx.type == 'income') {
                totalIncome += tx.amount;
              } else if (tx.type == 'expense') {
                totalExpense += tx.amount
                    .abs(); // handles negative values if any
              }
            }

            final totalBalance = totalIncome - totalExpense;

            // Number formatting
            final currencyFormat = NumberFormat.currency(
              symbol: 'Nu. ',
              decimalDigits: 0,
            );

            final incomeStr = currencyFormat.format(totalIncome);
            final expenseStr = currencyFormat.format(totalExpense);
            final balanceStr = currencyFormat.format(totalBalance);

            return Column(
              children: [
                // Title row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Money Tracker',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Date selector + financial summary
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 2,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Year + Month (stacked vertically)
                      GestureDetector(
                        onTap: () async {
                          final selected =
                              await showModalBottomSheet<Map<String, int>>(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) => MonthYearPickerSheet(
                                  initialYear: selectedYear,
                                  initialMonth: selectedMonth,
                                ),
                              );

                          if (selected != null && mounted) {
                            setState(() {
                              selectedMonth = selected['month']!;
                              selectedYear = selected['year']!;
                            });
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Year (smaller, above)
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
                            // Month (bigger, with dropdown arrow)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  DateFormat('MMMM').format(
                                    DateTime(selectedYear, selectedMonth),
                                  ),
                                  // 'MMMM' = full month name, use 'MMM' for short
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
                                  size: 28,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Financial summary items
                      _buildSummaryItem(
                        'Expenses',
                        expenseStr,
                        Theme.of(context).colorScheme.error,
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                      const SizedBox(width: 20),

                      _buildSummaryItem(
                        'Income',
                        incomeStr,
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                      const SizedBox(width: 20),

                      _buildSummaryItem(
                        'Balance',
                        balanceStr,
                        totalBalance >= 0
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.error,
                        Theme.of(context).colorScheme.onPrimary,
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

  Widget _buildSummaryItem(
    String label,
    String value,
    Color valueColor,
    Color labelColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: labelColor.withOpacity(0.85)),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
