import 'package:flutter/material.dart';

class GoalListItem extends StatelessWidget {
  final String heading;
  final String amount;
  final String deadline;
  final String sourceAccount;
  final String priority;
  final String percentage;
  const GoalListItem({
    super.key,
    required this.amount,
    required this.deadline,
    required this.heading,
    required this.priority,
    required this.sourceAccount,
    required this.percentage,
  });
  Color getPriorityColor(BuildContext context, priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Color(0xFFF97358);
      case 'medium':
        return Colors.orange;
      case 'low':
        return Theme.of(context).primaryColor;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align columns to top
          children: [
            // Left side: icon + heading
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: getPriorityColor(context, priority),
                  ),
                  child: const Icon(
                    Icons.home_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 60),

            // Right side: progress and details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$percentage% complete',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Stack(
                    children: [
                      Container(
                        width: 176,
                        height: 10,

                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        height: 10,
                        width: (int.parse(percentage) / 100) * 176,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.red,
                            ], // From black to red
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Target Amount",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(amount, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8.5),
                  
                  buildRow('Deadline', deadline),
                  const SizedBox(height: 8.5),
                  buildRow('Source Amount', sourceAccount),
                  const SizedBox(height: 8.5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Priority Level",
                        style: TextStyle(fontSize: 12),
                      ),
                      Container(
                        height: 18,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          priority,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(fontSize: 12)),
      Text(value, style: const TextStyle(fontSize: 12)),
    ],
  );
}
