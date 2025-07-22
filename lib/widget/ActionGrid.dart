import 'package:ekonomi_new/widget/ActionItem.dart';
import 'package:flutter/material.dart';

class ActionGrid extends StatelessWidget {
  final List<ActionItem> items = [
    ActionItem(
      title: 'Add Savings',
      subtitle: 'Boost your savings by adding funds now.',
      icon: Icons.add,
      filled: true,
    ),
    ActionItem(
      title: 'Goals',
      subtitle: 'Plan, save, and reach your milestones',
      icon: Icons.track_changes,
      filled: false,
    ),
    ActionItem(
      title: 'Transaction',
      subtitle: 'Track every transaction with ease',
      icon: Icons.swap_vert,
      filled: false,
    ),
    ActionItem(
      title: 'Spending',
      subtitle: 'Track spending, stay in control',
      icon: Icons.currency_rupee,
      filled: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
