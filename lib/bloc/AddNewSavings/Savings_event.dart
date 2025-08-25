abstract class SavingsEvent {}

class AmountChanged extends SavingsEvent {
  final String amount;
  AmountChanged(this.amount);
}

class DateChanged extends SavingsEvent {
  final String date;
  DateChanged(this.date);
}

class CategoryChanged extends SavingsEvent {
  final String value;
  CategoryChanged(this.value);
}

class PaymentChanged extends SavingsEvent {
  final String value;
  PaymentChanged(this.value);
}

class UndoForm extends SavingsEvent {}

class SaveForm extends SavingsEvent {}
