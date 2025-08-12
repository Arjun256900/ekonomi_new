import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:ekonomi_new/widgets/reminder_screen/month_calender.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
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
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.045),
              child: Column(
                children: [
                  FilterWidget(
                    filters: ['All', 'Overdue', 'Due today', 'Upcoming'],
                  ),
                  const SizedBox(height: 15),
                  MonthCalendar(),
                  const SizedBox(height: 15),
                  TransactionList(
                    transactions: [
                      TransactionItem(
                        date: 'Jun 5',
                        time: "6 pm",
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '300',
                      ),
                      TransactionItem(
                        date: 'Jun 5',
                        time: "6 pm",
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '300',
                      ),
                      TransactionItem(
                        date: 'Jun 5',
                        time: "6 pm",
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '300',
                      ),
                      TransactionItem(
                        date: 'Jun 5',
                        time: "6 pm",
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '300',
                      ),
                      TransactionItem(
                        date: 'Jun 5',
                        time: "6 pm",
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '300',
                      ),
                      TransactionItem(
                        date: 'Jun 5',
                        time: "6 pm",
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '300',
                      ),
                      TransactionItem(
                        date: 'Jun 5',
                        time: "6 pm",
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '300',
                      ),
                      TransactionItem(
                        date: 'Jun 5',
                        time: "6 pm",
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '300',
                      ),
                      TransactionItem(
                        date: 'Jun 5',
                        time: "6 pm",
                        heading: 'Swiggy',
                        sendOrReceived: 'Send',
                        amount: '300',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
