import 'package:flutter/foundation.dart';

class SavingsGlobal {
  static final SavingsGlobal _instance = SavingsGlobal._internal();
  factory SavingsGlobal() => _instance;
  SavingsGlobal._internal();

  final ValueNotifier<List<Map<String, dynamic>>> savingsListNotifier =
      ValueNotifier([]);

  double get totalSavings {
    return savingsListNotifier.value.fold<double>(
      0,
      (sum, item) => sum + double.tryParse(item['amount'] ?? '0')!,
    );
  }

  void addSaving(Map<String, dynamic> saving) {
    savingsListNotifier.value = [
      ...savingsListNotifier.value,
      saving,
    ];
  }
}
