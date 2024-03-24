part of 'money_bloc.dart';

@freezed
class MoneyState with _$MoneyState {
  const factory MoneyState.idle(
      {required int moneyLeft, required List<MoneyChange> changes}) = _Idle;

  const factory MoneyState.processing(
      {required int moneyLeft,
      required List<MoneyChange> changes}) = _Processing;
}
