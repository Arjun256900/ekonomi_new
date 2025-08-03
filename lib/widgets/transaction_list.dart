import 'package:ekonomi_new/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

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
            Row(
              children: [
                SizedBox(
                  width: 45,
                  child: Text("Date & time", textAlign: TextAlign.center),
                ),
                const SizedBox(width: 35),
                const Text("Transactions"),
              ],
            ),
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
