class TransactionState {
  final String debitOrCredit;
  final String amount;
  final String date;
  final String sourceSelection;
  final String category;
  final String filepath;
  final String allocationId;
  final bool isValid;

  TransactionState({
    required this.debitOrCredit,
    required this.amount,
    required this.date,
    required this.sourceSelection,
    required this.category,
    required this.filepath,
    required this.allocationId,
    required this.isValid,
  });

  factory TransactionState.initial() {
    return TransactionState(
      debitOrCredit: '',
      amount: '',
      date: '',
      sourceSelection: '',
      category: '',
      filepath: '',
      allocationId: '',
      isValid: false,
    );
  }

  TransactionState copyWith({
    String? debitOrCredit,
    String? amount,
    String? date,
    String? sourceSelection,
    String? category,
    String? filepath,
    String? allocationId,
    bool? isValid,
  }) {
    return TransactionState(
      debitOrCredit: debitOrCredit ?? this.debitOrCredit,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      sourceSelection: sourceSelection ?? this.sourceSelection,
      category: category ?? this.category,
      filepath: filepath ?? this.filepath,
      allocationId: allocationId ?? this.allocationId,
      isValid: isValid ?? this.isValid,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'debitOrCredit': debitOrCredit,
      'amount': amount,
      'date': date,
      'sourceSelection': sourceSelection,
      'category': category,
      'filepath': filepath,
      'allocationId': allocationId,
    };
  }
}
