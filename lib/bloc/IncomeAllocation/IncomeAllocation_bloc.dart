import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'IncomeAlllocation_Events.dart';
import 'IncomeAllocation_State.dart';
import '../../models/IncomeAllocation.dart';

class IncomeAllocationBloc
    extends Bloc<IncomeAllocationEvent, IncomeAllocationState> {
  IncomeAllocationBloc()
      : super(const IncomeAllocationState(
          totalIncome: 0,
          allocations: [],
          selectedAllocationId: 'ALL',
        )) {
    on<LoadDefaultAllocations>(_loadDefaults);
    on<AddAllocation>(_add);
    on<UpdateAllocation>(_update);
    on<DeleteAllocation>(_delete);
    on<SelectAllocation>(_selectAllocation);
  }

  void _loadDefaults(
    LoadDefaultAllocations event,
    Emitter<IncomeAllocationState> emit,
  ) {
    final defaults = [
      IncomeAllocation(
        id: 'tax',
        title: 'Income Tax',
        subtitle: 'Weekly',
        amount: 0,
        icon: Icons.receipt,
        isDefault: true,
      ),
      IncomeAllocation(
        id: 'home',
        title: 'Home',
        subtitle: 'Monthly',
        amount: 0,
        icon: Icons.home,
        isDefault: true,
      ),
      IncomeAllocation(
        id: 'groceries',
        title: 'Groceries',
        subtitle: 'Weekly',
        amount: 0,
        icon: Icons.shopping_cart,
        isDefault: true,
      ),
    ];

    emit(
      state.copyWith(
        totalIncome: event.totalIncome,
        allocations: defaults,
        selectedAllocationId:
            defaults.isNotEmpty ? defaults.first.id : 'ALL',
      ),
    );
  }

  void _add(AddAllocation event, Emitter<IncomeAllocationState> emit) {
    final updated = [...state.allocations, event.allocation];
    emit(
      state.copyWith(
        allocations: updated,
        selectedAllocationId: event.allocation.id, // auto-select new
      ),
    );
  }

  void _update(UpdateAllocation event, Emitter<IncomeAllocationState> emit) {
    final updated = state.allocations
        .map((a) => a.id == event.allocation.id ? event.allocation : a)
        .toList();

    emit(state.copyWith(allocations: updated));
  }

  void _delete(DeleteAllocation event, Emitter<IncomeAllocationState> emit) {
    final updated = state.allocations.where((a) => a.id != event.id).toList();

    final selected = updated.any((a) => a.id == state.selectedAllocationId)
        ? state.selectedAllocationId
        : (updated.isNotEmpty ? updated.first.id : 'ALL');

    emit(state.copyWith(
      allocations: updated,
      selectedAllocationId: selected,
    ));
  }

  void _selectAllocation(
      SelectAllocation event, Emitter<IncomeAllocationState> emit) {
    final exists = state.allocations.any((a) => a.id == event.allocationId);
    emit(state.copyWith(
        selectedAllocationId: exists ? event.allocationId : 'ALL'));
  }
}
