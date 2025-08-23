import 'package:flutter/material.dart';

class QuickSummary extends StatelessWidget {
  final String amount;
  const QuickSummary({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF03969D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('You can save upto', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\u{20B9} $amount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      'In this month',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              Image.asset("assets/opportunities/graph_increase.png"),
            ],
          ),
        ],
      ),
    );
  }
}
