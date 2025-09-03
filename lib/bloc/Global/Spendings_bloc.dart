import 'package:flutter/foundation.dart';

class SpendingsGlobal {
  static final SpendingsGlobal _instance = SpendingsGlobal._internal();
  factory SpendingsGlobal() => _instance;
  SpendingsGlobal._internal();

  /// Manual spendings (not in TransactionListBloc)
  final ValueNotifier<List<Map<String, dynamic>>> spendingListNotifier =
      ValueNotifier([]);

  /// Add a manual spending
  void addSpending(Map<String, dynamic> spending) {
    spendingListNotifier.value = [
      ...spendingListNotifier.value,
      spending,
    ];
  }

  /// Sum of manual spendings only
  double get manualSpendings {
    return spendingListNotifier.value.fold<double>(
      0,
      (sum, item) => sum + (double.tryParse(item['amount']?.toString() ?? '0') ?? 0),
    );
  }

  /// 🔥 Combined total (manual + transactions)
  double calculateTotalSum(List<Map<String, dynamic>> transactionList) {
    final spendingSum = manualSpendings;

    final transactionSum = transactionList.fold<double>(
      0,
      (sum, item) =>
          sum + (double.tryParse(item['amount']?.toString() ?? '0') ?? 0),
    );

    return spendingSum + transactionSum;
  }
}
