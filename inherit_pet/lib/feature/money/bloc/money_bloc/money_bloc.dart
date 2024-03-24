import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_event.dart';
part 'money_state.dart';
part 'money_bloc.freezed.dart';

class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {
  MoneyBloc({required MoneyState initialState}) : super(initialState) {
    on<MoneyEvent>((event, emit) => event.map(
      modifyMoney: (event) => _modifyMoney(event, emit)
    ));
  }


  Future<void> _modifyMoney(_ModifyMoney event, Emitter<MoneyState> emitter) async {

  }
}
