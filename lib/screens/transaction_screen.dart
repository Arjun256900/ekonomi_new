import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_state.dart';
import 'package:ekonomi_new/screens/add_new_transaction_screen.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:ekonomi_new/widgets/transaction_screen/transaction_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                title: Text(
                  "Transaction Management",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 70,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Add New Transaction'),
                                CircleAvatar(
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
                        const SizedBox(width: 12),
                        Container(
                          height: 70,
                          width: 70,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Icon(Icons.mic_none_outlined, size: 25),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Recent Transaction",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 25),
                    FilterWidget(
                      filters: [
                        'All',
                        '7 days',
                        '30 days',
                        '90 days',
                        '180 days',
                      ],
                    ),
                    const SizedBox(height: 25),
                    Expanded(
                      child:
                          BlocBuilder<
                            TransactionListBloc,
                            TransactionListState
                          >(
                            builder: (context, state) {
                              if (state.transactions.isEmpty) {
                                return Center(
                                  child: Text("No transactions yet."),
                                );
                              }

                              return TransactionList(
                                transactions: state.transactions.map((tx) {
                                  return TransactionItem(
                                    date: tx['date'] ?? '',
                                    time: tx['time'] ?? '',
                                    heading: tx['category'] ?? '',
                                    sendOrReceived: tx['debitOrCredit'] ?? '',
                                    amount: tx['amount'] ?? '',
                                  );
                                }).toList(),
                              );
                            },
                          ),
                    ),
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
