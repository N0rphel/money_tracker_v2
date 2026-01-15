import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayHeader extends StatelessWidget {
  final DateTime date;

  const DayHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final formattedDay = DateFormat('EEEE, d MMM').format(date);
    final isToday = _isSameDay(date, DateTime.now());

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isToday ? 'Today · $formattedDay' : formattedDay,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          // Container(
          //   width: double.infinity,
          //   height: 1,
          //   color: Theme.of(context).dividerColor,
          // ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
