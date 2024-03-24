part of 'money_bloc.dart';

@freezed
class MoneyEvent with _$MoneyEvent {
  const factory MoneyEvent.modifyMoney({
    required Change change,
  }) = _ModifyMoney;
}