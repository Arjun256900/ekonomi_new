import 'package:ekonomi_new/screens/add_event_screen.dart';
import 'package:ekonomi_new/screens/add_new_savings.dart';
import 'package:ekonomi_new/screens/ocassion_planner_screen.dart';
import 'package:ekonomi_new/screens/opportunities_screen.dart';
import 'package:ekonomi_new/screens/set_goal.dart';
import 'package:ekonomi_new/screens/spending_screen.dart';
import 'package:ekonomi_new/screens/transaction_screen.dart';
import 'package:ekonomi_new/widgets/home_screen/action_item.dart';
import 'package:flutter/material.dart';

class ActionGrid extends StatelessWidget {
  final List<ActionItem> items = [
    ActionItem(
      title: 'Add Savings',
      subtitle: 'Boost your savings by adding funds now.',
      icon: Icons.add,
      filled: true,
      navigation: AddNewSavings(),
    ),
    ActionItem(
      title: 'Goals',
      subtitle: 'Plan, save, and reach your milestones',
      icon: Icons.track_changes,
      filled: false,
      navigation: SetGoal(),
    ),
    ActionItem(
      title: 'Transaction',
      subtitle: 'Track every transaction with ease',
      icon: Icons.swap_vert,
      filled: false,
      navigation: TransactionScreen(),
    ),
    ActionItem(
      title: 'Spending',
      subtitle: 'Track spending, stay in control',
      icon: Icons.currency_rupee,
      filled: false,
      navigation: SpendingScreen(),
    ),
    ActionItem(
      title: 'Ocassional Planner',
      subtitle: 'Plan Your Special Moments',
      icon: Icons.celebration,
      filled: false,
      navigation: OcassionPlannerScreen(),
    ),
    ActionItem(
      title: 'Add Event',
      subtitle: 'Plan and Save Your Moments',
      icon: Icons.confirmation_num,
      filled: false,
      navigation: AddEventScreen(),
    ),
  ];

  ActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (_, idx) {
        final it = items[idx];
        return ActionCard(item: it);
      },
    );
  }
}
