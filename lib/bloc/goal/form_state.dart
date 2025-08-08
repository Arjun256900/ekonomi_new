class GoalState {
  final String goalName;
  final String amount;
  final String date;
  final String priority;
  final String sourceAccount;
  final bool isValid;

  GoalState({
    required this.goalName,
    required this.amount,
    required this.date,
    required this.priority,
    required this.sourceAccount,
    required this.isValid,
  });

  factory GoalState.initial() {
    return GoalState(
      goalName: '',
      amount: '',
      date: '',
      priority: '',
      sourceAccount: '',
      isValid: false,
    );
  }

  GoalState copyWith({
    String? goalName,
    String? amount,
    String? date,
    String? priority,
    String? sourceAccount,
    bool? isValid,
  }) {
    return GoalState(
      goalName: goalName ?? this.goalName,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      priority: priority ?? this.priority,
      sourceAccount: sourceAccount ?? this.sourceAccount,
      isValid: isValid ?? this.isValid,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "goalName": goalName,
      "amount": amount,
      "date": date,
      "priority": priority,
      "sourceAccount": sourceAccount,
    };
  }
}
