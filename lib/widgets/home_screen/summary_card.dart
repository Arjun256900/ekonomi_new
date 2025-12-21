import 'package:ekonomi_new/bloc/Global/Spendings_bloc.dart';
import 'package:ekonomi_new/bloc/Global/savingsGlobal.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_State.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_bloc.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAlllocation_Events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final allocationState = context.watch<IncomeAllocationBloc>().state;
    final selectedAllocationId = allocationState.selectedAllocationId;
print(allocationState.allocations);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// ALLOCATION DROPDOWN
            /// 
            BlocBuilder<IncomeAllocationBloc, IncomeAllocationState>(
              builder: (context, allocationState) {
                // Use the first allocation as default if selectedAllocationId is empty
                final selectedId =
                    allocationState.selectedAllocationId.isNotEmpty
                    ? allocationState.selectedAllocationId
                    : (allocationState.allocations.isNotEmpty
                          ? allocationState.allocations.first.id
                          : 'ALL');

                return DropdownButtonFormField<String>(
                  value: selectedId,
                  decoration: const InputDecoration(
                    labelText: 'Select Category',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: 'ALL',
                      child: Text('All Categories'),
                    ),
                    ...allocationState.allocations.map(
                      (allocation) => DropdownMenuItem(
                        value: allocation.id,
                        child: Text(allocation.title),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    context.read<IncomeAllocationBloc>().add(
                      SelectAllocation(value),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 16),

            /// SPENDINGS
            ValueListenableBuilder(
              valueListenable: SpendingsGlobal().spendingListNotifier,
              builder: (context, _, __) {
                final totalSpendings = SpendingsGlobal().calculateByAllocation(
                  selectedAllocationId,
                );

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spendings',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹ ${totalSpendings.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF048B94),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'This Month',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),

            const Divider(height: 24, thickness: 1),

            /// SAVINGS
            ValueListenableBuilder(
              valueListenable: SavingsGlobal().savingsListNotifier,
              builder: (context, _, __) {
                final totalSavings = SavingsGlobal().calculateByAllocation(
                  selectedAllocationId,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Savings',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹ ${totalSavings.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
