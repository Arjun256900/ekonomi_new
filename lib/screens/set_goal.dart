import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/add_new_goal.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:ekonomi_new/widgets/general/add_btn_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ekonomi_new/widgets/goal_screen/goal_list_item.dart';
// import 'package:ekonomi_new/widgets/add_container.dart';

class SetGoal extends StatelessWidget {
  const SetGoal({super.key});

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
            title: Text("Goal", style: TextStyle(fontWeight: FontWeight.w600)),
            actions: [
              AddBtnAppbar(
                ontap: () {
                  Navigator.of(
                    context,
                  ).push(CupertinoPageRoute(builder: (context) => AddNewGoal()));
                },
                title: "Add Goal",
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
          
                Text(
                  "Ongoing Goal List",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                GoalListItem(
                  amount: "30,000",
                  deadline: "sep 2023",
                  heading: "Apartment",
                  priority: "High",
                  sourceAccount: "Dummy",
                  percentage: "50",
                ),
                const SizedBox(height: 12),
                GoalListItem(
                  amount: "30,000",
                  deadline: "sep 2023",
                  heading: "Apartment",
                  priority: "low",
                  sourceAccount: "Dummy",
                  percentage: "50",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
