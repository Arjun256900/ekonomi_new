import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAlllocation_Events.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_State.dart';
import 'package:ekonomi_new/models/IncomeAllocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeAllocationBloc
    extends Bloc<IncomeAllocationEvent, IncomeAllocationState> {
  IncomeAllocationBloc()
      : super(const IncomeAllocationState(
          totalIncome: 0,
          allocations: [],
        )) {
    on<LoadDefaultAllocations>(_loadDefaults);
    on<AddAllocation>(_add);
    on<UpdateAllocation>(_update);
    on<DeleteAllocation>(_delete);
  }

  void _loadDefaults(
      LoadDefaultAllocations e, Emitter emit) {
    emit(
      IncomeAllocationState(
        totalIncome: e.totalIncome,
        allocations: [
          IncomeAllocation(
            id: 'tax',
            title: 'Income Tax',
            subtitle: 'Default Account',
            amount: 0,
            icon: Icons.receipt,
          ),
          IncomeAllocation(
            id: 'home',
            title: 'Home',
            subtitle: 'Rent/Mortgage',
            amount: 0,
            icon: Icons.home,
          ),
          IncomeAllocation(
            id: 'groceries',
            title: 'Groceries',
            subtitle: 'Food & Supplies',
            amount: 0,
            icon: Icons.shopping_cart,
          ),
          IncomeAllocation(
            id: 'debts',
            title: 'Debts',
            subtitle: 'Credit Card, Loans',
            amount: 0,
            icon: Icons.credit_card,
          ),
        ],
      ),
    );
  }

  void _add(AddAllocation e, Emitter emit) {
    emit(state.copyWith(
      allocations: [...state.allocations, e.allocation],
    ));
  }

  void _update(UpdateAllocation e, Emitter emit) {
    emit(state.copyWith(
      allocations: state.allocations
          .map((a) => a.id == e.allocation.id ? e.allocation : a)
          .toList(),
    ));
  }

  void _delete(DeleteAllocation e, Emitter emit) {
    emit(state.copyWith(
      allocations:
          state.allocations.where((a) => a.id != e.id).toList(),
    ));
  }
}
