import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/add_new_transaction_screen.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:ekonomi_new/widgets/transaction_screen/transaction_list.dart';

import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_bloc.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_State.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAlllocation_Events.dart';

import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_event.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_state.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: BackButtonLeading(),
                backgroundColor: Colors.transparent,
                title: const Text(
                  "Transaction Management",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Add Transaction Card
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const AddNewTransactionScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 70,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Add New Transaction',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                    ),
                                  ),
                                  const CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Color.fromRGBO(
                                      232,
                                      245,
                                      246,
                                      1,
                                    ),
                                    child: Icon(Icons.add, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 70,
                          width: 70,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.mic_none_outlined, size: 25),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    /// Allocation Selection Dropdown
                    BlocBuilder<IncomeAllocationBloc, IncomeAllocationState>(
                      builder: (context, state) {
                        // Fallback to first allocation ID if selectedAllocationId is empty
                        final selectedId = state.selectedAllocationId.isNotEmpty
                            ? state.selectedAllocationId
                            : (state.allocations.isNotEmpty
                                  ? state.allocations.first.id
                                  : null);

                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'Select Category',
                          ),
                          value: selectedId,
                          items: [
                            const DropdownMenuItem(
                              value: 'ALL',
                              child: Text('All Categories'),
                            ),
                            ...state.allocations.map(
                              (allocation) => DropdownMenuItem<String>(
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

                    const SizedBox(height: 25),

                    /// Date Filter
                    BlocBuilder<TransactionListBloc, TransactionListState>(
                      builder: (context, transactionState) {
                        return FilterWidget(
                          filters: const [
                            'All',
                            '7 days',
                            '30 days',
                            '90 days',
                            '180 days',
                          ],
                          selectedFilter: transactionState.selectedDateFilter,
                          onFilterChanged: (filter) {
                            context.read<TransactionListBloc>().add(
                              UpdateDateFilterEvent(filter),
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 25),

                    /// Transaction List
                    const Expanded(child: TransactionList()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
