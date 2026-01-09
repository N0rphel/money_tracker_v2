import 'package:flutter/material.dart';
import 'package:money_tracker_v2/constants/categories.dart';
import 'package:money_tracker_v2/views/widgets/number_input.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  String? selectedCategory;
  IconData? selectedIcon;

  void _onCategorySelected(String label, IconData icon) {
    setState(() {
      selectedCategory = label;
      selectedIcon = icon;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => NumberInputBottomSheet(
            category: label,
            icon: icon,
            type: 'expense',
          ),
        ).then((_) {
          setState(() {
            selectedCategory = null;
            selectedIcon = null;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final category = expenseCategories[index];
              final isSelected = selectedCategory == category['label'];
              return _buildCategoryItem(
                icon: category['icon'],
                label: category['label'],
                isSelected: isSelected,
                onTap: () =>
                    _onCategorySelected(category['label'], category['icon']),
              );
            }, childCount: expenseCategories.length),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: AnimatedScale(
              scale: isSelected ? 0.9 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Colors.black,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
