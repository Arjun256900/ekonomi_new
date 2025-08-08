abstract class TransactionEvent {}

class DebitOrCreditChanged extends TransactionEvent {
  final String value;
  DebitOrCreditChanged(this.value);
}

class AmountChanged extends TransactionEvent {
  final String value;
  AmountChanged(this.value);
}

class DateChanged extends TransactionEvent {
  final String value;
  DateChanged(this.value);
}

class SourceSelectionChanged extends TransactionEvent {
  final String value;
  SourceSelectionChanged(this.value);
}

class CategoryChanged extends TransactionEvent {
  final String value;
  CategoryChanged(this.value);
}

class FilepathChanged extends TransactionEvent {
  final String value;
  FilepathChanged(this.value);
}

class SubmitTransaction extends TransactionEvent {}

class UndoTransaction extends TransactionEvent {} 
