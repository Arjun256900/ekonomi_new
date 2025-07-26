import 'package:ekonomi_new/widget/AlertItem.dart';
import 'package:ekonomi_new/widget/filterWidget.dart';
import 'package:flutter/material.dart';

class Alertdash extends StatefulWidget {
  const Alertdash({super.key});

  @override
  State<Alertdash> createState() => _AlertdashState();
}

class _AlertdashState extends State<Alertdash> {
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
        Filterwidget(filters: ['All', 'Bills', 'Overdue', 'Investements']),
        const SizedBox(height: 15),
        Alertitem(
          heading: "Wifi Connection",
          amount: "300",
          due: "due",
          date: "in 2 days",
        ),
      ],
    );
  }
}
