import 'package:flutter/material.dart';

class RecordAppbar extends StatelessWidget {
  const RecordAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 102,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            // Top row with icons and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Text(
                          '2026',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      // Show month picker
                    },
                    child: Row(
                      children: [
                        Text(
                          'Jan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Expenses
                  _buildSummaryItem(
                    'Expenses',
                    '8,320',
                    Theme.of(context).colorScheme.onPrimary,
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 16),
                  // Income
                  _buildSummaryItem(
                    'Income',
                    '0',
                    Theme.of(context).colorScheme.onPrimary,
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 16),
                  // Total balance
                  _buildSummaryItem(
                    'Total balance',
                    '21,995',
                    Theme.of(context).colorScheme.onPrimary,
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    Color labelColor,
    Color valueColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: labelColor)),
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
