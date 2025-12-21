import 'package:ekonomi_new/models/IncomeModel.dart';

class IncomeState {
  final List<IncomeSource> incomes;
  final String selectedAccountId; // NEW

  IncomeState({
    required this.incomes,
    this.selectedAccountId = 'ALL',
  });

  IncomeState copyWith({
    List<IncomeSource>? incomes,
    String? selectedAccountId,
  }) {
    return IncomeState(
      incomes: incomes ?? this.incomes,
      selectedAccountId:
          selectedAccountId ?? this.selectedAccountId,
    );
  }

  double get totalIncome =>
      incomes.fold(0, (sum, item) => sum + item.amount);
}
