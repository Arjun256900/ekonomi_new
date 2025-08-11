import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/add_new_spending.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:ekonomi_new/widgets/general/add_btn_appbar.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ekonomi_new/widgets/spending_screen/spending_chart.dart';
import 'package:ekonomi_new/widgets/spending_screen/spending_legend.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: backButtonLeading(),
              backgroundColor: Colors.transparent,
              title: Text(
                "Spending",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              actions: [
                AddBtnAppbar(
                  ontap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => AddNewSpending(),
                      ),
                    );
                  },
                  title: "Add",
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        FilterWidget(
                          filters: ['This week', 'This Month', 'Jun', 'Aug'],
                        ),
                        const SizedBox(height: 40),
                        SpendingChart(
                          values: [40, 25, 20, 15], // to be fed by backend
                          colors: [
                            Color(0xFF00A896),
                            Color(0xFF5267DF),
                            Color(0xFFF9A826),
                            Color(0xFFF76C6C),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Total spending'), Text("₹ 1300")],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Lable section
                  SpendingLegend(
                    labels: ['Bills', 'Travel', 'Food', 'Others'],
                    percentages: [40, 20, 22, 18], // match your chart data
                    colors: [
                      Color(0xFF00A896), // teal (Bills)
                      Color(0xFFF76C6C), // coral (Travel)
                      Color(0xFFF9A826), // yellow (Food)
                      Color(0xFF5267DF), // blue (Others)
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
