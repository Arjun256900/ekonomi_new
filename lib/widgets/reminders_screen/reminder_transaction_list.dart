import 'package:ekonomi_new/widgets/reminders_screen/reminder_card.dart';
import 'package:flutter/material.dart';

class ReminderItem {
  final String reminderAmount;
  final String date;
  final String time;
  final String reminderTitle;

  const ReminderItem({
    required this.reminderAmount,
    required this.reminderTitle,
    required this.date,
    required this.time,
  });
}

class ReminderTransactionList extends StatefulWidget {
  final List<ReminderItem> reminderItems;
  const ReminderTransactionList({super.key, required this.reminderItems});

  @override
  State<ReminderTransactionList> createState() =>
      _ReminderTransactionListState();
}

class _ReminderTransactionListState extends State<ReminderTransactionList> {
  @override
  Widget build(BuildContext context) {
    //  fixed heights matching TransactionCard + separator
    const double cardHeight = 135;
    const double separatorHeight = 12;

    final double listHeight =
        widget.reminderItems.length * cardHeight +
        (widget.reminderItems.length - 1) * separatorHeight;
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
                'Reminders',
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
                  children: widget.reminderItems.asMap().entries.map((entry) {
                    final rm = entry.value;
                    final idx = entry.key;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: idx == widget.reminderItems.length - 1
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
                                  rm.date,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  rm.time,
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
                            child: ReminderCard(
                              reminderTitle: rm.reminderTitle,
                              amount: rm.reminderAmount,
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
