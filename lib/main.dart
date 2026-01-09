import 'package:flutter/material.dart';
import 'package:money_tracker_v2/views/theme/theme.dart';
import 'package:money_tracker_v2/views/theme/theme_notifier.dart';
import 'package:money_tracker_v2/views/widget_tree.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeNotifier.themeMode,
          home: WidgetTree(),
        );
      },
    );
  }
}
