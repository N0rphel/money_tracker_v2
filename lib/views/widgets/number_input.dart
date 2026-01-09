import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberInputBottomSheet extends StatefulWidget {
  final String category;
  final IconData icon;
  final String type;

  const NumberInputBottomSheet({
    super.key,
    required this.category,
    required this.icon,
    required this.type,
  });

  @override
  State<NumberInputBottomSheet> createState() => _NumberInputBottomSheetState();
}

class _NumberInputBottomSheetState extends State<NumberInputBottomSheet> {
  String amount = '0';
  String notes = '';
  DateTime selectedDate = DateTime.now();

  void _onNumberPressed(String number) {
    setState(() {
      if (amount == '0') {
        amount = number;
      } else {
        amount += number;
      }
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (!amount.contains('.')) {
        amount += '.';
      }
    });
  }

  void _onBackspace() {
    setState(() {
      if (amount.length > 1) {
        amount = amount.substring(0, amount.length - 1);
      } else {
        amount = '0';
      }
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _saveExpense() {
    final expense = {
      'category': widget.category,
      'amount': double.tryParse(amount) ?? 0.0,
      'type': widget.type,
      'notes': notes,
      'date': selectedDate,
    };

    // TODO: Save to your database/state management
    print('Saving expense: $expense');

    Navigator.pop(context, expense);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65, // 65% of screen
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header with category
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(widget.icon, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      widget.category,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: _saveExpense,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Amount Display
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Nu. ${amount}',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),

          // Date and Notes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Date selector
                InkWell(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18),
                        const SizedBox(width: 12),
                        Text(
                          DateFormat('MMM dd, yyyy').format(selectedDate),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Notes input
                TextField(
                  onChanged: (value) => notes = value,
                  decoration: InputDecoration(
                    hintText: 'Add notes (optional)',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.note, size: 20),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),

          const Spacer(),

          // Number Pad
          _buildNumberPad(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNumberPad() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildNumberRow(['1', '2', '3']),
          const SizedBox(height: 10),
          _buildNumberRow(['4', '5', '6']),
          const SizedBox(height: 10),
          _buildNumberRow(['7', '8', '9']),
          const SizedBox(height: 10),
          _buildNumberRow(['.', '0', '⌫']),
        ],
      ),
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Row(
      children: numbers.map((number) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildNumberButton(number),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNumberButton(String value) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          if (value == '⌫') {
            _onBackspace();
          } else if (value == '.') {
            _onDecimalPressed();
          } else {
            _onNumberPressed(value);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 56,
          alignment: Alignment.center,
          child: Text(
            value,
            style: TextStyle(
              fontSize: value == '⌫' ? 24 : 28,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
