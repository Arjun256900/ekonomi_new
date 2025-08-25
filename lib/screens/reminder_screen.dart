import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:ekonomi_new/widgets/general/month_calender.dart';
import 'package:ekonomi_new/widgets/reminders_screen/reminder_card.dart';
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                        ),
                        child: Column(
                          children: [
                            ReminderCard(
                              reminderTitle: "Loan EMI - HDFC",
                              amount: "₹5,000",
                              date: "Oct 06, 2024, 10:00 AM",
                            ),
                            const SizedBox(height: 10),
                            ReminderCard(
                              reminderTitle: "Loan EMI - HDFC",
                              amount: "₹5,000",
                              date: "Oct 06, 2024, 10:00 AM",
                            ),
                          ],
                        ),
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
