import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inherit_pet/feature/money/model/change.dart';
import 'package:inherit_pet/feature/money/money_data_source/money_data_source.dart';

part 'money_event.dart';
part 'money_state.dart';
part 'money_bloc.freezed.dart';

class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {

  final MoneyDataSource _moneyDataSource;

  MoneyBloc(this._moneyDataSource, {required MoneyState initialState}) : super(initialState) {
    on<MoneyEvent>((event, emit) => event.map(
      modifyMoney: (event) => _modifyMoney(event, emit)
    ));
  }


  Future<void> _modifyMoney(_ModifyMoney event, Emitter<MoneyState> emitter) async {
    emitter(MoneyState.processing(moneyLeft: state.moneyLeft, changes: state.changes));

    final emState = 
      state.copyWith(
        moneyLeft: event.change.changeType == ChangeType.income 
          ? state.moneyLeft + event.change.money
          : state.moneyLeft - event.change.money
        )
        ..changes.add(event.change);
        
    _moneyDataSource.setMoney(emState.moneyLeft);
    _moneyDataSource.setChanges(emState.changes);

    emitter(emState);
  }
}
