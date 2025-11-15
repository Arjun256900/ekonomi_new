import 'package:ekonomi_new/screens/add_new_debt.dart';
import 'package:ekonomi_new/widgets/debt_screen/action_button.dart';
import 'package:flutter/cupertino.dart';

class BottomButtons extends StatefulWidget {
  const BottomButtons({super.key});

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            label: 'Add Debt',
            onTap: () {
              Navigator.of(
                context,
              ).push(CupertinoPageRoute(builder: (context) => AddNewDebt()));
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ActionButton(label: 'Set Reminder', onTap: () {}),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ActionButton(label: 'View Insights', onTap: () {}),
        ),
      ],
    );
  }
}
