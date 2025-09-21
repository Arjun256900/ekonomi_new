import 'package:flutter/material.dart';

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

class SubmitTransaction extends TransactionEvent {
  final BuildContext context;
  SubmitTransaction(this.context);
}

class UndoTransaction extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final Map<String, dynamic> transaction;
  final BuildContext context;

  AddTransaction(this.transaction, this.context);
}
