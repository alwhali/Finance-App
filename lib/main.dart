import 'package:finance_app/models/finance_model.dart';
import 'package:finance_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Ensure any async initialization is complete before running the app
  await Hive.initFlutter();
  Hive.registerAdapter(FinanceModelAdapter());
  await Hive.openBox<FinanceModel>('finance_box');
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Finance App",

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
