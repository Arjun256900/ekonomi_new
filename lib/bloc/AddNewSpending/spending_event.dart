import 'package:flutter/material.dart';


abstract class SpendingEvent {}

class AmountChanged extends SpendingEvent{
  final String value;
  AmountChanged(this.value);
}

class DateChanged extends SpendingEvent{
  final String value;
  DateChanged(this.value);
}


class NotesChanged extends SpendingEvent{
  final String value;
  NotesChanged(this.value);
}


class FilepathChanged extends SpendingEvent{
  final String value;
  FilepathChanged(this.value);
}

class SubmitSpending extends SpendingEvent {
  final BuildContext context;
  SubmitSpending(this.context);
}

class UndoSpending extends SpendingEvent {} 
