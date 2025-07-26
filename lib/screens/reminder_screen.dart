import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/transaction_screen.dart';
import 'package:ekonomi_new/widget/backButton.dart';
import 'package:ekonomi_new/widget/filterWidget.dart';
import 'package:ekonomi_new/widgets/month_calender.dart';
import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove outer Stack
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButtonLeading(),
        backgroundColor: Colors.transparent,
        title: Text("Reminders", style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Background()),
          Padding(
            padding: const EdgeInsets.only(top: 100, right: 20, left: 20),
            child: Column(
              children: [
                Filterwidget(
                  filters: ['All', 'Overdue', 'Due today', 'Upcoming'],
                ),
                const SizedBox(height: 15),
                MonthCalendar(),
                const SizedBox(height: 15),
                Expanded(child: TransactionList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
