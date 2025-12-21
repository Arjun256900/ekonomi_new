import 'package:ekonomi_new/models/IncomeAllocation.dart';

abstract class IncomeAllocationEvent {}

class LoadDefaultAllocations extends IncomeAllocationEvent {
  final double totalIncome;
  LoadDefaultAllocations({required this.totalIncome});
}

class AddAllocation extends IncomeAllocationEvent {
  final IncomeAllocation allocation;
  AddAllocation(this.allocation);
}

class UpdateAllocation extends IncomeAllocationEvent {
  final IncomeAllocation allocation;
  UpdateAllocation(this.allocation);
}

class DeleteAllocation extends IncomeAllocationEvent {
  final String id;
  DeleteAllocation(this.id);
}

class SelectAllocation extends IncomeAllocationEvent {
  final String allocationId;
  SelectAllocation(this.allocationId);
}
