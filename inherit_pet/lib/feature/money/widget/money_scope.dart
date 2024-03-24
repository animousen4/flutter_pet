import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inherit_pet/feature/money/bloc/money_bloc/money_bloc.dart';
import 'package:inherit_pet/feature/money/model/change.dart';
import 'package:inherit_pet/feature/money/widget/money_controller.dart';

class MoneyScope extends StatefulWidget {
  final MoneyBloc moneyBloc;

  final Widget child;

  const MoneyScope({required this.moneyBloc, required this.child, super.key});

  static MoneyContoller moneyOf(BuildContext context) => context.getInheritedWidgetOfExactType<_InheritedMoney>()!.moneyContoller;

  /// ??? подписываемся на изменения состояния 
  static MoneyState moneyStateOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_InheritedMoney>()!.moneyState;

  @override
  State<MoneyScope> createState() => _MoneyScopeState();
}

class _MoneyScopeState extends State<MoneyScope> 
    implements MoneyContoller {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyBloc, MoneyState>(
      bloc: widget.moneyBloc,
      builder: (context, state) {
        return _InheritedMoney(moneyState: state, moneyContoller: this, child: widget.child);
      },
    );
  }

  @override
  void modifyMoney(MoneyChange change) {
    widget.moneyBloc.add(MoneyEvent.modifyMoney(change: change));
  }
}

class _InheritedMoney extends InheritedWidget {

  final MoneyState moneyState;

  final MoneyContoller moneyContoller;

  const _InheritedMoney({required this.moneyState, required this.moneyContoller, required super.child});

  @override
  bool updateShouldNotify(covariant _InheritedMoney oldWidget) {

    bool shouldUpdate = 
      oldWidget.moneyState.changes != moneyState.changes ||
      oldWidget.moneyState.moneyLeft != moneyState.moneyLeft;


    return shouldUpdate;
  }

}