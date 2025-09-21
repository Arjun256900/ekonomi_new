import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_bloc.dart';
import 'package:ekonomi_new/bloc/Global/Spendings_bloc.dart';
import 'package:ekonomi_new/bloc/Global/savingsGlobal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ get transaction list from bloc
    final transactionList =
        context.watch<TransactionListBloc>().state.transactions;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 Spendings section
            ValueListenableBuilder(
              valueListenable: SpendingsGlobal().spendingListNotifier,
              builder: (context, _, __) {
                final globalTotal =
                    SpendingsGlobal().calculateTotalSum();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spendings',
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹ ${globalTotal.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
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

            // 🔹 Savings section
            ValueListenableBuilder(
              valueListenable: SavingsGlobal().savingsListNotifier,
              builder: (context, _, __) {
                final totalSavings = SavingsGlobal().totalSavings;

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
