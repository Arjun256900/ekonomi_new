import 'package:flutter/foundation.dart';

class SpendingsGlobal {
  static final SpendingsGlobal _instance = SpendingsGlobal._internal();
  factory SpendingsGlobal() => _instance;
  SpendingsGlobal._internal();

  /// Holds total spendings for each category
  final ValueNotifier<Map<String, double>> categoryTotalsNotifier =
      ValueNotifier({
    'food': 0.0,
    'bills': 0.0,
    'travel': 0.0,
    'others': 0.0,
  });

  /// Holds the global total of all categories
  final ValueNotifier<double> globalTotalNotifier = ValueNotifier(0.0);

  /// Optional: keep a list of manual spendings (if you still need it)
  final ValueNotifier<List<Map<String, dynamic>>> spendingListNotifier =
      ValueNotifier([]);

  /// Add a manual spending (and update category + global sums)
  // void addSpending(Map<String, dynamic> spending) {
  //   spendingListNotifier.value = [...spendingListNotifier.value, spending];
  //   _updateCategoryTotals(spending);
  // }

  /// Add a transaction from anywhere (manual or streamed)
  void addTransaction(Map<String, dynamic> transaction) {
    _updateCategoryTotals(transaction);
  }

  /// Core updater
  void _updateCategoryTotals(Map<String, dynamic> tx) {
    final rawCategory = tx['category']?.toString().toLowerCase() ?? 'others';
    final category = categoryTotalsNotifier.value.containsKey(rawCategory)
        ? rawCategory
        : 'others';

    final amount = double.tryParse(tx['amount']?.toString() ?? '0') ?? 0;

    // Update category total
    final updatedMap = Map<String, double>.from(categoryTotalsNotifier.value);
    updatedMap[category] = (updatedMap[category] ?? 0) + amount;
    categoryTotalsNotifier.value = updatedMap;

    // Update global total

  }
    /// Returns a map of category -> percentage of total spending
  Map<String, double> getCategoryPercentages() {
    final total = calculateTotalSum();
    if (total == 0) {
      // avoid division by zero
      return {
        'food': 0,
        'bills': 0,
        'travel': 0,
        'others': 0,
      };
    }

    final Map<String, double> percentages = {};
    categoryTotalsNotifier.value.forEach((category, amount) {
      percentages[category] = (amount / total) * 100;
    });

    return percentages;
  }

  /// Read-only helpers
  double get foodTotal => categoryTotalsNotifier.value['food'] ?? 0;
  double get billsTotal => categoryTotalsNotifier.value['bills'] ?? 0;
  double get travelTotal => categoryTotalsNotifier.value['travel'] ?? 0;
  double get othersTotal => categoryTotalsNotifier.value['others'] ?? 0;
  double calculateTotalSum() {
    return categoryTotalsNotifier.value.values
        .fold<double>(0.0, (sum, val) => sum + val);
  }
  double get globalTotal => globalTotalNotifier.value;
}
