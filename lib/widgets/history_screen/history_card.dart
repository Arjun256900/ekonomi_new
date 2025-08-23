import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String date;
  final String historyText;
  final String amount;
  const HistoryCard({
    super.key,
    required this.amount,
    required this.date,
    required this.historyText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date, style: TextStyle(color: Colors.grey[500], height: 1.25)),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Give the history text the remaining horizontal space so it can wrap
              Expanded(
                child: Text(
                  historyText,
                  style: const TextStyle(fontSize: 14),
                  softWrap: true,
                  // remove maxLines or set to desired limit; null means unlimited
                  maxLines: null,
                ),
              ),

              const SizedBox(width: 8),

              // Keep amount to the right; use Column to align to top if text wraps
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
