import 'package:flutter/material.dart';
import 'package:money_tracker_v2/views/widgets/record_appbar.dart';

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
      body: const Center(child: Text('This is the Records Page')),
    );
  }
}
