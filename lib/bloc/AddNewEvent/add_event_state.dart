

class AddEventState {
  final String title;
  final String? date;
  final String budget;
  final String strategy;
  final String? linkToGoal;
  final bool isReminderSelected;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const AddEventState({
    this.title = '',
    this.date,
    this.budget = '',
    this.strategy = '',
    this.linkToGoal,
    this.isReminderSelected = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  AddEventState copyWith({
    String? title,
    String? date,
    String? budget,
    String? strategy,
    String? linkToGoal,
    bool? isReminderSelected,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return AddEventState(
      title: title ?? this.title,
      date: date ?? this.date,
      budget: budget ?? this.budget,
      strategy: strategy ?? this.strategy,
      linkToGoal: linkToGoal ?? this.linkToGoal,
      isReminderSelected: isReminderSelected ?? this.isReminderSelected,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'title': title,
    'date': date,
    'budget': budget,
    'strategy': strategy,
    'linkToGoal': linkToGoal,
    'isReminderSelected': isReminderSelected,
  };
}
}
