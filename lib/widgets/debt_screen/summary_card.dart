import 'package:ekonomi_new/widgets/debt_screen/summary_column.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});
  static double get _cardRadius => 12.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SummaryColumn(title: 'Total Debt', value: '₹2,45,000'),
          const SizedBox(width: 10),
          Expanded(
            child: SummaryColumn(title: 'Monthly Payment', value: '₹13,500'),
          ),
          const SizedBox(width: 10),
          SummaryColumn(title: 'Interest', value: '12.5%'),
        ],
      ),
    );
  }
}
