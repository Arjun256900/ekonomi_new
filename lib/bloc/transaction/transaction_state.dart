class TransactionState {
  final String debitOrCredit;
  final String amount;
  final String date;
  final String sourceSelection;
  final String category;
  final String filepath;
  // final bool showErrors;

  TransactionState({
    required this.debitOrCredit,
    required this.amount,
    required this.date,
    required this.sourceSelection,
    required this.category,
    required this.filepath,
    // required this.showErrors,
  });

  factory TransactionState.initial() {
    return TransactionState(
      debitOrCredit: '',
      amount: '',
      date: '',
      sourceSelection: '',
      category: '',
      filepath: '',
      // showErrors: false,
    );
  }

  TransactionState copyWith({
    String? debitOrCredit,
    String? amount,
    String? date,
    String? sourceSelection,
    String? category,
    String? filepath,
    // bool? showErrors,
  }) {
    return TransactionState(
      debitOrCredit: debitOrCredit ?? this.debitOrCredit,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      sourceSelection: sourceSelection ?? this.sourceSelection,
      category: category ?? this.category,
      filepath: filepath ?? this.filepath,
      // showErrors: showErrors ?? this.showErrors,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "debitOrCredit": debitOrCredit,
      "amount": amount,
      "date": date,
      "sourceSelection": sourceSelection,
      "category": category,
      "filepath": filepath,
    };
  }
}
