

abstract class GoalEvent {}

class GoalNameChanged extends GoalEvent {
  final String goalName;
  GoalNameChanged(this.goalName);
}

class TargetAmountChanged extends GoalEvent {
  final String amount;
  TargetAmountChanged(this.amount);
}

class TargetDateChanged extends GoalEvent {
  final String date;
  TargetDateChanged(this.date);
}

class PrioityLevelChanged extends GoalEvent{
  final String prioity;
  PrioityLevelChanged(this.prioity);
}
class SourceAccountChanged extends GoalEvent{
  final String sourceAccount;
  SourceAccountChanged(this.sourceAccount);
}

class SubmitGoal extends GoalEvent {

}
