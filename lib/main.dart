import 'package:flutter/material.dart';
import 'package:money_tracker_v2/data/database.dart';
import 'package:money_tracker_v2/data/transaction_repository.dart';
import 'package:money_tracker_v2/data/transaction_provider.dart';
import 'package:money_tracker_v2/views/theme/theme.dart';
import 'package:money_tracker_v2/views/theme/theme_notifier.dart';
import 'package:money_tracker_v2/views/widget_tree.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Database db;

  try {
    db = await AppDatabase.database; // ← await here
    debugPrint('Database ready for providers');
  } catch (e) {
    debugPrint('Fatal error: Unable to initialize database. $e');
    // You could show an error screen instead of running the app
    return;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),

        // Now safe - we pass the resolved Database instance
        Provider.value(value: db),

        Provider(create: (_) => TransactionRepository(db)),

        ChangeNotifierProvider(
          create: (context) =>
              TransactionProvider(context.read<TransactionRepository>()),
        ),
      ],
      child: const MyApp(),
    ),
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
