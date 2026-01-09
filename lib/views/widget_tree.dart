import 'package:flutter/material.dart';
import 'package:money_tracker_v2/data/notifiers.dart';
import 'package:money_tracker_v2/views/pages/profile.dart';
import 'package:money_tracker_v2/views/pages/records.dart';
import 'package:money_tracker_v2/views/widgets/bottom_navbar.dart';
import 'package:money_tracker_v2/views/widgets/fab.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return _getPage(selectedPage);
        },
      ),
      floatingActionButton: AddFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavBarWidget(),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const RecordsPage();
      case 1:
        return const ProfilePage();
      default:
        return const RecordsPage();
    }
  }
}
