import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:ekonomi_new/widgets/general/month_calender.dart';
import 'package:ekonomi_new/widgets/transaction_screen/transaction_list.dart';
import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: backButtonLeading(),
            backgroundColor: Colors.transparent,
            title: Text(
              "Reminders",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FilterWidget(
                  filters: ['All', 'Overdue', 'Due today', 'Upcoming'],
                ),
                const SizedBox(height: 15),
                MonthCalendar(),
                const SizedBox(height: 15),
                Expanded(
                  child: TransactionList(
                    transactions: [
                      TransactionItem(
                        dateTime: 'Jun 5 6 pm',
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '300',
                      ),
                      TransactionItem(
                        dateTime: 'Jun 5 6 pm',
                        heading: 'Swiggy',
                        sendOrReceived: 'Received',
                        amount: '2829',
                      ),
                      TransactionItem(
                        dateTime: 'Jun 5 6 pm',
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '679',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
