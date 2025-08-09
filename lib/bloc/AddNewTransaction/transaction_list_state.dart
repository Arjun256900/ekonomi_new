class TransactionListState {
  final List<Map<String, dynamic>> transactions;

  TransactionListState({required this.transactions});

  TransactionListState copyWith({List<Map<String, dynamic>>? transactions}) {
    return TransactionListState(transactions: transactions ?? this.transactions);
  }
}
