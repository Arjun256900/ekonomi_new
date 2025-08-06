import 'package:ekonomi_new/widgets/home_screen/alert_item.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:flutter/material.dart';

class AlertDash extends StatefulWidget {
  const AlertDash({super.key});

  @override
  State<AlertDash> createState() => _AlertDashState();
}

class _AlertDashState extends State<AlertDash> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Alerts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        FilterWidget(filters: ['All', 'Bills', 'Overdue', 'Investements']),
        const SizedBox(height: 20),
        AlertItem(
          heading: "Wifi Connection",
          amount: "300",
          due: "due",
          date: "in 2 days",
        ),
      ],
    );
  }
}
