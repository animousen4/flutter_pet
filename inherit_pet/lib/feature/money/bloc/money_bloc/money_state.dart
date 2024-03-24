part of 'money_bloc.dart';

@freezed
class MoneyState with _$MoneyState {
  const factory MoneyState.idle({
    required int moneyLeft,
    required List<Change> changes
  }) = _Idle;
}
