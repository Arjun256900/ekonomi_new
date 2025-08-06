import 'package:flutter/material.dart';

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
