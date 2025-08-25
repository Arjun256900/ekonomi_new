import 'package:flutter/material.dart';

class ReminderCard extends StatefulWidget {
  final String reminderTitle;
  final String amount;
  final String date;
  const ReminderCard({
    super.key,
    required this.reminderTitle,
    required this.amount,
    required this.date,
  });

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon and description
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(widget.reminderTitle),
                              Text(widget.amount),
                            ],
                          ),
                          Text(widget.date),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
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
            ],
          ),
        ],
      ),
    );
  }
}
