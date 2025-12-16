import 'package:ekonomi_new/models/IncomeModel.dart';

class IncomeState {
  final List<IncomeSource> incomes;

  IncomeState({required this.incomes});

  double get totalIncome =>
      incomes.fold(0, (sum, item) => sum + item.amount);
}
