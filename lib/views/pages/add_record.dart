import 'package:flutter/material.dart';
import 'package:money_tracker_v2/views/pages/expense.dart';
import 'package:money_tracker_v2/views/pages/income.dart';

class AddRecordModal extends StatelessWidget {
  const AddRecordModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 17,
              ),
            ),
          ),
          leadingWidth: 80,
          title: Text(
            'Add',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: TabBar(
              indicatorColor: Theme.of(context).colorScheme.onPrimary,
              indicatorWeight: 2,
              textScaler: TextScaler.linear(1.2),
              labelColor: Theme.of(context).colorScheme.onPrimary,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
              tabs: const [
                Tab(text: 'Expense'),
                Tab(text: 'Income'),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [const AddExpense(), const AddIncome()]),
      ),
    );
  }
}
