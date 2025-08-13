import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:ekonomi_new/widgets/general/month_calender.dart';
import 'package:ekonomi_new/widgets/reminders_screen/reminder_transaction_list.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: BackButtonLeading(),
                backgroundColor: Colors.transparent,
                title: Text(
                  "Reminders",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                    left: screenWidth * 0.02,
                    right: screenWidth * 0.02,
                  ),
                  child: Column(
                    children: [
                      FilterWidget(
                        filters: ['All', 'Overdue', 'Due today', 'Upcoming'],
                      ),
                      const SizedBox(height: 15),
                      MonthCalendar(),
                      const SizedBox(height: 15),
                      ReminderTransactionList(
                        reminderItems: [
                          ReminderItem(
                            reminderAmount: "5000",
                            reminderTitle: "Loan EMI - HDFC",
                            date: "9 Apr",
                            time: "12am",
                          ),
                          ReminderItem(
                            reminderAmount: "5000",
                            reminderTitle: "Loan EMI - HDFC",
                            date: "9 Apr",
                            time: "12am",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
