import 'package:flutter/material.dart';
import 'package:money_tracker_v2/views/pages/add_record.dart';

class AddFloatingActionButton extends StatefulWidget {
  const AddFloatingActionButton({super.key});

  @override
  State<AddFloatingActionButton> createState() =>
      _AddFloatingActionButtonState();
}

class _AddFloatingActionButtonState extends State<AddFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          builder: (context) => const AddRecordModal(),
        );
      },
      backgroundColor: Colors.amber,
      elevation: 0,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Color.fromARGB(255, 72, 57, 57),
        size: 32,
      ),
    );
  }
}
