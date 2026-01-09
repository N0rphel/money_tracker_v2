import 'package:flutter/material.dart';
import 'package:money_tracker_v2/views/pages/add_record.dart';

class AddFloatingActionButton extends StatefulWidget {
  const AddFloatingActionButton({super.key});

  @override
  State<AddFloatingActionButton> createState() =>
      _AddFloatingActionButtonState();
}

class _AddFloatingActionButtonState extends State<AddFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.08,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openSheet(BuildContext context) async {
    // FAB press animation
    await _controller.forward();
    await _controller.reverse();

    // Bottom sheet animation (slower & smoother)
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 350),
        reverseDuration: const Duration(milliseconds: 250),
      ),
      builder: (_) => const AddRecordModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(scale: 1 - _controller.value, child: child);
      },
      child: FloatingActionButton(
        onPressed: () => _openSheet(context),
        backgroundColor: Colors.amber,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 72, 57, 57),
          size: 32,
        ),
      ),
    );
  }
}
