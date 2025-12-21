class TransactionListState {
  final List<Map<String, dynamic>> transactions;
  final String selectedAccountId;
  final String selectedDateFilter;

  TransactionListState({
    required this.transactions,
    this.selectedAccountId = 'ALL',
    this.selectedDateFilter = 'All',
  });

  TransactionListState copyWith({
    List<Map<String, dynamic>>? transactions,
    String? selectedAccountId,
    String? selectedDateFilter,
  }) {
    return TransactionListState(
      transactions: transactions ?? this.transactions,
      selectedAccountId: selectedAccountId ?? this.selectedAccountId,
      selectedDateFilter: selectedDateFilter ?? this.selectedDateFilter,
    );
  }

  List<Map<String, dynamic>> get filteredTransactions {
    var filtered = selectedAccountId == 'ALL'
        ? transactions
        : transactions.where((t) => t['accountId'] == selectedAccountId).toList();

    // Filter by date (simplified)
    if (selectedDateFilter != 'All') {
      final now = DateTime.now();
      int days = int.parse(selectedDateFilter.split(' ')[0]);
      filtered = filtered.where((t) {
        final txDate = DateTime.tryParse(t['date'] ?? '') ?? now;
        return now.difference(txDate).inDays <= days;
      }).toList();
    }

    return filtered;
  }

  double totalSavings() {
    return transactions
        .where((t) => t['debitOrCredit'] == 'Credit')
        .fold<double>(0, (sum, t) => sum + double.tryParse(t['amount'] ?? '0')!);
  }

  double savingsByAccount(String accountId) {
    return transactions
        .where((t) => t['debitOrCredit'] == 'Credit' && t['accountId'] == accountId)
        .fold<double>(0, (sum, t) => sum + double.tryParse(t['amount'] ?? '0')!);
  }
}
