enum Reason {
  car,

  product,

  salary,
}

enum ChangeType {
  expense,

  income
}

class MoneyChange {
  final ChangeType changeType;

  final String? note;

  final Reason reason;

  final int money;

  MoneyChange(
      {required this.changeType,
      this.note,
      required this.reason,
      required this.money});
}
