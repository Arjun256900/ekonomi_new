abstract class GoalListEvent {}

class AddGoalEvent extends GoalListEvent {
  final Map<String, dynamic> goalJson;
  AddGoalEvent(this.goalJson);
}

class RemoveGoalEvent extends GoalListEvent {
  final String goalId;
  RemoveGoalEvent(this.goalId);
}
