class SavingsState {
  final String amount;
  final String? date;
  final String? Category;
  final String? Payment;
  final bool saved;
  final Map<String, dynamic>? jsonResult;

  SavingsState({
    this.amount = '',
    this.date,
    this.Category,
    this.Payment,
    this.saved = false,
    this.jsonResult,
  });

  SavingsState copyWith({
    String? amount,
    String? date,
    String? Category,
    String? Payment,
    bool? saved,
    Map<String, dynamic>? jsonResult,
  }) {
    return SavingsState(
      amount: amount ?? this.amount,
      date: date ?? this.date,
      Category: Category ?? this.Category,
      Payment: Payment ?? this.Payment,
      saved: saved ?? this.saved,
      jsonResult: jsonResult,
    );
  }
}
