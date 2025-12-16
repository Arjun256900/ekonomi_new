import 'package:ekonomi_new/models/IncomeAllocation.dart';

class IncomeAllocationState {
  final double totalIncome;
  final List<IncomeAllocation> allocations;

  const IncomeAllocationState({
    required this.totalIncome,
    required this.allocations,
  });

  double get totalAllocated =>
      allocations.fold(0, (sum, e) => sum + e.amount);

  double get remaining =>
      totalIncome - totalAllocated;

  IncomeAllocationState copyWith({
    double? totalIncome,
    List<IncomeAllocation>? allocations,
  }) {
    return IncomeAllocationState(
      totalIncome: totalIncome ?? this.totalIncome,
      allocations: allocations ?? this.allocations,
    );
  }
}
