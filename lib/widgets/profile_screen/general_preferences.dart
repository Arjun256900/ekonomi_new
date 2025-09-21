import 'package:ekonomi_new/screens/coupons.dart';
import 'package:ekonomi_new/screens/reminder_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralPreferences extends StatelessWidget {
  const GeneralPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Personal Information
          GestureDetector(
            onTap: () {
              // ✅ Handle navigation here
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.person),
                    const SizedBox(width: 20),
                    Text(
                      "Personal information",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Financial Overview
          GestureDetector(
            onTap: () {
              print("Financial overview tapped");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.chart_bar),
                    const SizedBox(width: 20),
                    Text("Financial overview", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Coupons
          GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).push(CupertinoPageRoute(builder: (context) => CouponsScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.tickets),
                    const SizedBox(width: 20),
                    Text("Coupons", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Reminders
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => ReminderScreen()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    const SizedBox(width: 20),
                    Text("Reminders", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Security
          GestureDetector(
            onTap: () {
              print("Security tapped");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.lock_outline),
                    const SizedBox(width: 20),
                    Text("Security", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
