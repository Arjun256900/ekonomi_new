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
                  Expanded(child: TransactionList()),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Vertical line
            Positioned(
              left: 65,
              top: 40, // Start below header
              bottom: 0,
              child: Container(
                width: 6,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(217, 217, 217, 0.39),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 45,
                        child: Text("Date & time", textAlign: TextAlign.center),
                      ),
                      const SizedBox(width: 35),
                      const Text("Transactions"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Transaction items with scroll
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      _buildTransactionRow(
                        "Jun 5 6 pm",
                        "send",
                        "1300",
                        "Swiggy",
                      ),
                      const SizedBox(height: 8),
                      _buildTransactionRow(
                        "Jun 5 6 pm",
                        "received",
                        "1300",
                        "Swiggy",
                      ),
                      // Add more transactions here
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTransactionRow(
    String date,
    String type,
    String amount,
    String title,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 45, child: Text(date, textAlign: TextAlign.center)),
        const SizedBox(width: 35),
        Expanded(
          child: TransactionCard(
            sendOrReceived: type,
            amount: amount,
            heading: title,
          ),
        ),
      ],
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String heading;
  final String sendOrReceived;
  final String amount;

  const TransactionCard({
    super.key,
    required this.sendOrReceived,
    required this.amount,
    required this.heading,
  });

  Color getDebitOrCredit(BuildContext context, String debitOrCredit) {
    switch (sendOrReceived.toLowerCase()) {
      case 'send':
        return const Color(0xFFFF0000);
      case 'received':
        return Theme.of(context).primaryColor;
      default:
        return const Color(0xFFF97358);
    }
  }

  String getDebitOrCreditIcon(String debitOrCredit) {
    return sendOrReceived.toLowerCase() == 'send' ? '-' : '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Icon
            Container(
              height: 41,
              width: 41,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(3, 150, 157, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.room_service,
                size: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),

            // Text content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sendOrReceived,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              '${getDebitOrCreditIcon(sendOrReceived)}₹$amount',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: getDebitOrCredit(context, sendOrReceived),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
