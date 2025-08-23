import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/AddNewGoal/goal_list_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewGoal/goal_list_state.dart';
import 'package:ekonomi_new/screens/add_new_goal.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/general/add_btn_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ekonomi_new/widgets/goal_screen/goal_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetGoal extends StatelessWidget {
  const SetGoal({super.key});

  @override
  Widget build(BuildContext context) {
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
                title: const Text(
                  "Goal",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                actions: [
                  AddBtnAppbar(
                    ontap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => AddNewGoal()),
                      );
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
                    const Text(
                      "Ongoing Goal List",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // listen to GoalListBloc
                    Expanded(
                      child: BlocBuilder<GoalListBloc, GoalListState>(
                        builder: (context, state) {
                          if (state.goals.isEmpty) {
                            return const Center(
                              child: Text("No goals added yet."),
                            );
                          }

                          return ListView.builder(
                            itemCount: state.goals.length,
                            itemBuilder: (context, index) {
                              final goal = state.goals[index];
                              return Column(
                                children: [
                                  GoalListItem(
                                    amount: goal['amount'].toString(),
                                    deadline: goal['date'] ?? "",
                                    heading: goal['goalName'] ?? "",
                                    priority: goal['priority'] ?? "Low",
                                    sourceAccount: goal['sourceAccount'] ?? "",
                                    percentage: "50", // constant for now
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          );
                        },
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
