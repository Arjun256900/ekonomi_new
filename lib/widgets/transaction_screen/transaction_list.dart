import 'package:ekonomi_new/widgets/transaction_screen/transaction_card.dart';
import 'package:flutter/material.dart';

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
  /// List of transaction entries to display.
  final List<TransactionItem> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    //  fixed heights matching TransactionCard + separator
    const double cardHeight = 68;
    const double separatorHeight = 12;

    // calculate the total height of all transaction cards to dynamically resize the vertical divider
    final double listHeight =
        transactions.length * cardHeight +
        (transactions.length - 1) * separatorHeight;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              SizedBox(
                width: 45,
                child: Text(
                  'Date & Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 35),
              Text(
                'Transactions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // SizedBox drives stack height dynamically
          SizedBox(
            height: listHeight,
            child: Stack(
              children: [
                // Vertical divider with dynamic height
                Positioned(
                  left: 45 + 35 / 2,
                  top: 0,
                  height: listHeight,
                  child: Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 0.39),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // card items
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 45,
                            height: 68,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
