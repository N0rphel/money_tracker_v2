import 'package:flutter/material.dart';
import 'package:money_tracker_v2/data/notifiers.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return BottomAppBar(
          color: Theme.of(context).bottomAppBarTheme.color,
          elevation: 0,
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 70.0,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  context: context,
                  icon: Icons.description,
                  label: 'Records',
                  isSelected: selectedPage == 0,
                  index: 0,
                  onTap: () => selectedPageNotifier.value = 0,
                ),
                const SizedBox(width: 60),
                _buildNavItem(
                  context: context,
                  icon: Icons.person_outline,
                  label: 'Me',
                  index: 1,
                  isSelected: selectedPage == 1,
                  onTap: () => selectedPageNotifier.value = 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required int index,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Colors.amber
                  : Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey
                  : Colors.black54,
              size: 28,
            ),
            const SizedBox(height: 1),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.amber
                    : Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey
                    : Colors.black54,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
