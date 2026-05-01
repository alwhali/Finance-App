import 'package:finance_app/cubit/add_cubit/add_data_cubit_cubit.dart';
import 'package:finance_app/cubit/fetch_cubit/fetch_data_cubit.dart';
import 'package:finance_app/models/finance_model.dart';

import 'package:finance_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    //1- you can provide a single cubit using BlocProvider :
    // BlocProvider(
    //   create: (context) => AddDataCubit(),
    //   child: ChildA(),
    // )
    // OR
    //2- you can use MultiBlocProvider if you have multiple cubits to provide :
    //     MultiBlocProvider(
    //   providers: [
    //     BlocProvider<BlocA>(
    //       create: (BuildContext context) => BlocA(),
    //     ),
    //     BlocProvider<BlocB>(
    //       create: (BuildContext context) => BlocB(),
    //     ),
    //     BlocProvider<BlocC>(
    //       create: (BuildContext context) => BlocC(),
    //     ),
    //   ],
    //   child: ChildA(),
    // )
    return BlocProvider(
      create: (context) => FetchDataCubit(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Finance App",

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
