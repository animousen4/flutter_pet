import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inherit_pet/feature/money/model/change.dart';
import 'package:inherit_pet/feature/money/widget/money_scope.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final moneyState = MoneyScope.moneyStateOf(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text("Money App"),
        ),
        SliverList.builder(
          itemBuilder: (context, index) =>
              MoneyChangeCard(moneyChange: moneyState.changes[index]),
          itemCount: moneyState.changes.length,
        )
      ],
    ));
  }
}

class MoneyWidget extends StatelessWidget {
  const MoneyWidget({required this.money, super.key});

  final int money;

  @override
  Widget build(BuildContext context) {
    return Text("Money left $money");
  }
}

class MoneyChangeCard extends StatelessWidget {
  final MoneyChange moneyChange;
  const MoneyChangeCard({required this.moneyChange, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(moneyChange.money.toString()),
      title: Text(moneyChange.reason.toString()),
      subtitle: moneyChange.note == null ? null : Text(moneyChange.note!),
    );
  }
}
