class GoalListState {
  final List<Map<String, dynamic>> goals;

  GoalListState({required this.goals});

  GoalListState copyWith({List<Map<String, dynamic>>? goals}) {
    return GoalListState(goals: goals ?? this.goals);
  }
}
