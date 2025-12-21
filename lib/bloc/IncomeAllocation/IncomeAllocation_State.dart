import 'package:ekonomi_new/models/IncomeAllocation.dart';

class IncomeAllocationState {
  final double totalIncome;
  final List<IncomeAllocation> allocations;
  final String allocationId;

  final String selectedAllocationId;

  const IncomeAllocationState({
    required this.totalIncome,
    required this.allocations,
    this.selectedAllocationId = 'ALL',
    this.allocationId = '',
  });

  /// ✅ Total allocated amount
  double get totalAllocated {
    return allocations.fold(0, (sum, a) => sum + a.amount);
  }

  /// ✅ Remaining income
  double get remaining {
    return totalIncome - totalAllocated;
  }

  IncomeAllocationState copyWith({
    double? totalIncome,
    List<IncomeAllocation>? allocations,
    String? selectedAllocationId,
    String? allocationId,
  }) {
    return IncomeAllocationState(
      totalIncome: totalIncome ?? this.totalIncome,
      allocations: allocations ?? this.allocations,
      selectedAllocationId: selectedAllocationId ?? this.selectedAllocationId,
      allocationId: allocationId ?? this.allocationId,
    );
  }
}
