import 'package:flutter/material.dart';
import 'package:money_tracker_v2/views/widgets/card_header.dart';
import 'package:money_tracker_v2/views/widgets/record_appbar.dart';
import 'package:money_tracker_v2/views/widgets/transaction_card.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(102),
        child: RecordAppbar(),
      ),
      body: Column(
        children: [
          CardHeader(title: "August 2023"),
          TransactionCard(
            icon: Icons.monetization_on,
            category: "category",
            type: "expense",
            amount: 100.0,
          ),
          CardHeader(title: "July 2023"),
          TransactionCard(
            icon: Icons.monetization_on,
            category: "category",
            type: "income",
            amount: 100.0,
          ),
        ],
      ),
    );
  }
}
