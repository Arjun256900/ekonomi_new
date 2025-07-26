import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widget/backButton.dart';
import 'package:ekonomi_new/widget/filterWidget.dart';
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Add new Transaction",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
                  Filterwidget(
                    filters: [
                      'All',
                      '7 days',
                      '30 days',
                      '90 days',
                      '180 days',
                    ],
                  ),
                  const SizedBox(height: 25),
                  TransactionList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 65),
              height: 500,
              width: 6,
              decoration: BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 0.39),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      child: Text("Date & time", textAlign: TextAlign.center),
                    ),
                    const SizedBox(width: 35),
                    Text("Transactions"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 45,
                      child: Text("Jun 5 6 pm", textAlign: TextAlign.center),
                    ),
                    const SizedBox(width: 35),
                    TransactionCard(
                      sendOrReceived: "send",
                      amount: "1300",
                      heading: "Swiggy",
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 45,
                      child: Text("Jun 5 6 pm", textAlign: TextAlign.center),
                    ),
                    const SizedBox(width: 35),
                    TransactionCard(
                      sendOrReceived: "received",
                      amount: "1300",
                      heading: "Swiggy",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class TransactionCard extends StatefulWidget {
  final String heading;
  final String sendOrReceived;
  final String amount;
  const TransactionCard({
    super.key,
    required this.sendOrReceived,
    required this.amount,
    required this.heading,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
  Color getDebitOrCredit(BuildContext context, String debitOrCredit) {
    switch (sendOrReceived.toLowerCase()) {
      case 'send':
        return Color(0xFFFF0000);
      case 'received':
        return Theme.of(context).primaryColor;
      default:
        return Color(0xFFF97358);
    }
  }

  String getDebitOrCreditIcon(BuildContext context, debitOrCredit) {
    if (sendOrReceived.toLowerCase() == 'send') {
      return '-';
    } else if (sendOrReceived.toLowerCase() == "received") {
      return '';
    } else {
      return '';
    }
  }
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 272,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 41,
              width: 41,
              decoration: BoxDecoration(
                color: Color.fromRGBO(3, 150, 157, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.room_service, size: 24, color: Colors.white),
            ),
            const SizedBox(width: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.heading,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 60),
                Text(
                  widget.sendOrReceived,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 2),
            Text(
              widget.getDebitOrCreditIcon(context, widget.sendOrReceived) +
                  ' ₹' +
                  widget.amount,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: widget.getDebitOrCredit(context, widget.sendOrReceived),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
