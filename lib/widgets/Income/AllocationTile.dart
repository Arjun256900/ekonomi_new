import 'dart:ui';

import 'package:ekonomi_new/models/IncomeAllocation.dart';
import 'package:flutter/material.dart';

class AllocationTile extends StatelessWidget {
  final IncomeAllocation allocation;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;

  const AllocationTile({
    super.key,
    required this.allocation,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(allocation.icon, color: Colors.teal),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(allocation.title,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16)),
                Text(allocation.subtitle,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(
            "\$${allocation.amount.toStringAsFixed(2)}",
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text("Edit")),
              const PopupMenuItem(value: 'delete', child: Text("Delete")),
            ],
            onSelected: (v) {
              if (v == 'edit') onEdit();
              if (v == 'delete') onDelete!();
            },
          ),
        ],
      ),
    );
  }
}
