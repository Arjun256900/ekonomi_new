import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/add_new_goal.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:ekonomi_new/widgets/general/add_btn_appbar.dart';
import 'package:ekonomi_new/widgets/general/month_calender.dart';
import 'package:ekonomi_new/widgets/ocassional_planner/event_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OcassionPlannerScreen extends StatefulWidget {
  const OcassionPlannerScreen({super.key});

  @override
  State<OcassionPlannerScreen> createState() => _OcassionPlannerScreenState();
}

class _OcassionPlannerScreenState extends State<OcassionPlannerScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: BackButtonLeading(),
              title: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // keeps it aligned left
                mainAxisSize: MainAxisSize.min, // avoids taking full height
                children: [
                  Text(
                    "Occasional",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Text(
                    "Planner",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),

              backgroundColor: Colors.transparent,
              actions: [
                AddBtnAppbar(
                  ontap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) => AddNewGoal()),
                    );
                  },
                  title: "Add Occasion",
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.02,
                right: screenWidth * 0.02,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MonthCalendar(),
                    const SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.022,
                        right: screenWidth * 0.022,
                      ),
                      child: GridView.count(
                        physics:
                            NeverScrollableScrollPhysics(), // already inside single child scroll view
                        shrinkWrap: true, // giving only necessary height
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: [
                          EventCard(
                            eventText:
                                "Dad's Birthday for the first time in this world of the greatest of the attrocious",
                            imagePath:
                                "assets/occasional_planner/occasional_planner_1.png",
                          ),
                          EventCard(
                            eventText: "Shopping for Diwali",
                            imagePath:
                                "assets/occasional_planner/occasional_planner_2.png",
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
      ],
    );
  }
}
