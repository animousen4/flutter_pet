import 'package:flutter/material.dart';
import 'package:inherit_pet/feature/init/scope/dependency_scope.dart';
import 'package:inherit_pet/feature/money/bloc/money_bloc/money_bloc.dart';
import 'package:inherit_pet/feature/money/money_data_source/money_data_source.dart';
import 'package:inherit_pet/feature/money/widget/money_scope.dart';
import 'package:inherit_pet/feature/money/widget/money_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moneyDataSource = DependencyScope.dependenciesOf(context).moneyDataSource;
    return MoneyScope(
      moneyBloc: MoneyBloc(
        moneyDataSource,
        initialState: const MoneyState.processing(moneyLeft: 0, changes: [])),
        child: const TransactionsPage()
    );
  }
}
