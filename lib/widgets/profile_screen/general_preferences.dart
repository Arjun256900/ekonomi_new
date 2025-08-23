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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CupertinoIcons.person),
                  const SizedBox(width: 20),
                  Text("Personal information", style: TextStyle(fontSize: 16)),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 15),
            ],
          ),
          const SizedBox(height: 18),
          Row(
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
          const SizedBox(height: 18),
          Row(
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
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month_outlined, weight: 40),
                  const SizedBox(width: 20),
                  Text("Reminders", style: TextStyle(fontSize: 16)),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 15),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.lock_outline, weight: 40),
                  const SizedBox(width: 20),
                  Text("Security", style: TextStyle(fontSize: 16)),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 15),
            ],
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
