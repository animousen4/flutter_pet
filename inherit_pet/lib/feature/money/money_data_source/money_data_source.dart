import 'package:inherit_pet/feature/money/model/change.dart';

abstract interface class MoneyDataSource {
  Future<int> getMoney();

  Future<List<MoneyChange>> getChanges();


  Future<void> setMoney(int money);

  Future<void> setChanges(List<MoneyChange> changes);

  Future<void> saveChange(MoneyChange change);
}


class MoneyDataSourceInMemory implements MoneyDataSource {
  
  int money = 220;

  List<MoneyChange> changes = [
    MoneyChange(changeType: ChangeType.income, note: "zp", reason: Reason.salary, money: 220)
  ];

  @override
  Future<List<MoneyChange>> getChanges() async => changes;

  @override
  Future<int> getMoney() async => money;

  @override
  Future<void> saveChange(MoneyChange change) async => changes.add(change);

  @override
  Future<void> setChanges(List<MoneyChange> changes) async => this.changes = changes;

  @override
  Future<void> setMoney(int money) async => this.money = money;

}