import 'package:flutter/material.dart';

class ReminderCard extends StatefulWidget {
  final String reminderTitle;
  final String amount;
  const ReminderCard({
    super.key,
    required this.reminderTitle,
    required this.amount,
  });

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/occasional_planner/occasional_planner_1.png'),
              Text(widget.reminderTitle),
              Text(widget.amount),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                  side: const BorderSide(
                    width: 0.5,
                    color: Color.fromRGBO(0, 0, 0, 0.45),
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text(
                "Pay now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
