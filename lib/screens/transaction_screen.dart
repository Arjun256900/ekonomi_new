import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_state.dart';
import 'package:ekonomi_new/screens/add_new_transaction_screen.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:ekonomi_new/widgets/new_transaction.dart';
import 'package:ekonomi_new/widgets/transaction_screen/transaction_list.dart';
import 'package:flutter/cupertino.dart';

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
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => AddNewTransactionScreen(),
                          ),
                        ),
                      },
                      child: Container(
                        width: 369,
                        height: 79,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),

                        child: Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            Container(
                              height: 48,
                              width: 4,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 215, 68, 1),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(3),
                                  bottomRight: Radius.circular(3),
                                ),
                              ),
                            ),
                            NewTransaction(),
                          ],
                        ),
                      ),
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
