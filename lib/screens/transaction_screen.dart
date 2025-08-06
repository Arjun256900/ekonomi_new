import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:ekonomi_new/widgets/new_transaction.dart';
import 'package:ekonomi_new/widgets/transaction_screen/transaction_list.dart';

import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: backButtonLeading(),
              backgroundColor: Colors.transparent,
              title: Text(
                "Transaction Management",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => {}, // this shoud be added there apfter
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                    child: TransactionList(
                      transactions: [
                        TransactionItem(
                          dateTime: 'Jun 5 6 pm',
                          heading: 'Swiggy',
                          sendOrReceived: 'Send',
                          amount: '300',
                        ),
                        TransactionItem(
                          dateTime: 'Jun 5 6 pm',
                          heading: 'Swiggy',
                          sendOrReceived: 'Send',
                          amount: '300',
                        ),
                        TransactionItem(
                          dateTime: 'Jun 5 6 pm',
                          heading: 'Swiggy',
                          sendOrReceived: 'Received',
                          amount: '1508',
                        ),
                        TransactionItem(
                          dateTime: 'Jun 5 6 pm',
                          heading: 'Swiggy',
                          sendOrReceived: 'Send',
                          amount: '300',
                        ),
                        TransactionItem(
                          dateTime: 'Jun 5 6 pm',
                          heading: 'Swiggy',
                          sendOrReceived: 'Send',
                          amount: '300',
                        ),
                        TransactionItem(
                          dateTime: 'Jun 5 6 pm',
                          heading: 'Swiggy',
                          sendOrReceived: 'Send',
                          amount: '300',
                        ),
                        TransactionItem(
                          dateTime: 'Jun 5 6 pm',
                          heading: 'Swiggy',
                          sendOrReceived: 'Send',
                          amount: '300',
                        ),
                        TransactionItem(
                          dateTime: 'Jun 5 6 pm',
                          heading: 'Swiggy',
                          sendOrReceived: 'Send',
                          amount: '300',
                        ),
                        //  more items can be added (from the backend)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
