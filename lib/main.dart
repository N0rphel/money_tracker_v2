import 'package:flutter/material.dart';
import 'package:money_tracker_v2/data/database.dart';
import 'package:money_tracker_v2/data/providers.dart';
import 'package:money_tracker_v2/modals/transaction.dart';
import 'package:money_tracker_v2/views/theme/theme.dart';
import 'package:money_tracker_v2/views/theme/theme_notifier.dart';
import 'package:money_tracker_v2/views/widget_tree.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDatabase.init();

  // await AppDatabase.debugTest();

  // final provider = TransactionProvider();
  // await provider.loadTransactions(); // Optional initial load

  // // await provider.deleteOldDatabase();

  // final tx = TransactionModel(
  //   id: const Uuid().v4(),
  //   amount: 999.0,
  //   date: DateTime.now(),
  //   category: 'Test Category',
  //   type: 'income',
  // );

  // await provider.addTransaction(tx);
  // print('After insert:');
  // provider.transactions.forEach((t) {
  //   print('${t.category}, ${t.amount}, ${t.type}, ${t.date}');
  // });

  // await provider.deleteTransaction(tx.id);
  // print('After delete:');
  // provider.transactions.forEach((t) {
  //   print('${t.category}, ${t.amount}, ${t.type}, ${t.date}');
  // });

  // await provider.loadTransactions();
  // print('After load:');
  // provider.transactions.forEach((t) {
  //   print('${t.category}, ${t.amount}, ${t.type}, ${t.date}');
  // });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        ), // existing theme
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(),
        ), // new transaction provider
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
