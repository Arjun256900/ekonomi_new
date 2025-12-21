import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_bloc.dart';
import 'package:ekonomi_new/widgets/transaction_screen/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_bloc.dart';

class TransactionItem {
  final String date;
  final String time;
  final String heading;
  final String sendOrReceived;
  final String amount;

  const TransactionItem({
    required this.date,
    required this.time,
    required this.heading,
    required this.sendOrReceived,
    required this.amount,
  });
}

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionState = context.watch<TransactionListBloc>().state;
    final allocationState = context.watch<IncomeAllocationBloc>().state;

    final selectedAllocationId = allocationState.selectedAllocationId;

    /// Date filter (optional)
    final selectedDateFilter = transactionState.selectedDateFilter ?? 'All';

    /// ✅ FILTER BY ALLOCATION (FIX)
    List<Map<String, dynamic>> filteredTransactions =
        selectedAllocationId == 'ALL'
        ? transactionState.transactions
        : transactionState.transactions
              .where((t) => t['allocationId'] == selectedAllocationId)
              .toList();

    /// ✅ DATE FILTER
    if (selectedDateFilter != 'All') {
      final now = DateTime.now();
      int days = 0;

      switch (selectedDateFilter) {
        case '7 days':
          days = 7;
          break;
        case '30 days':
          days = 30;
          break;
        case '90 days':
          days = 90;
          break;
        case '180 days':
          days = 180;
          break;
      }

      filteredTransactions = filteredTransactions.where((t) {
        final txDate = DateTime.tryParse(t['rawDate'] ?? '') ?? now;
        return now.difference(txDate).inDays <= days;
      }).toList();
    }

    /// Convert to UI model
    final transactions = filteredTransactions.map((t) {
      return TransactionItem(
        date: t['date'] ?? '',
        time: t['time'] ?? '',
        heading: t['category'] ?? '',
        sendOrReceived: t['sourceSelection'] ?? '',
        amount: t['amount'] ?? '',
      );
    }).toList();

    if (transactions.isEmpty) {
      return const Center(
        child: Text('No transactions', style: TextStyle(color: Colors.grey)),
      );
    }

    const double cardHeight = 68;
    const double separatorHeight = 12;

    final double listHeight =
        transactions.length * cardHeight +
        (transactions.length - 1) * separatorHeight;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              SizedBox(
                width: 45,
                child: Text(
                  'Date & Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 35),
              Text(
                'Transactions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: listHeight,
            child: Stack(
              children: [
                Positioned(
                  left: 45 + 35 / 2,
                  top: 0,
                  height: listHeight,
                  child: Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(217, 217, 217, 0.39),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Column(
                  children: transactions.asMap().entries.map((entry) {
                    final tx = entry.value;
                    final idx = entry.key;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: idx == transactions.length - 1
                            ? 0
                            : separatorHeight,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 45,
                            height: cardHeight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tx.date,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  tx.time,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 35),
                          Expanded(
                            child: TransactionCard(
                              heading: tx.heading,
                              sendOrReceived: tx.sendOrReceived,
                              amount: tx.amount,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
