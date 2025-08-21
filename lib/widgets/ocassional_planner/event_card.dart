import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final String eventText;
  final IconData icon;
  const EventCard({super.key, required this.eventText, required this.icon});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Color.fromRGBO(236, 236, 236, 1),
                child: Icon(widget.icon, color: Colors.teal),
              ),
              Text("Apr 15"),
            ],
          ),
          const SizedBox(height: 7),
          Expanded(
            child: SingleChildScrollView(
              child: Text(widget.eventText, style: TextStyle(fontSize: 16)),
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
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
                "Plan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
