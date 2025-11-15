import 'package:flutter/material.dart';

import 'package:ekonomi_new/widgets/debt_screen/debt_item.dart';

class DebtTile extends StatelessWidget {
  final DebtItem it;
  const DebtTile({super.key, required this.it});

  @override
  Widget build(BuildContext context) {
    final double cardRadius = 12.0;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.98),
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // icon / bank logo placeholder
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: it.iconBg ?? Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(it.iconData, size: 28, color: Colors.black54),
          ),
          const SizedBox(width: 12),
          // bank name & subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  it.bankName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      it.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      it.interest,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // amount & date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                it.amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                it.date,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
