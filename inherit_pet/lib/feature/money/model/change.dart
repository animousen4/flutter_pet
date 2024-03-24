enum Reason {
  car,

  product,

}

enum ChangeType {
  expense,

  income
}

class Change {

  final ChangeType changeType;

  final String? note;

  final Reason reason;

  final int money;

  Change({required this.changeType, required this.note, required this.reason, required this.money});
}