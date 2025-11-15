import 'package:ekonomi_new/background/backGround.dart';
import 'package:flutter/material.dart';

class DebtRepaymentStrategies extends StatefulWidget {
  const DebtRepaymentStrategies({super.key});

  @override
  State<DebtRepaymentStrategies> createState() =>
      _DebtRepaymentStrategiesState();
}

class _DebtRepaymentStrategiesState extends State<DebtRepaymentStrategies> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(child: SafeArea(child: Scaffold())),
      ],
    );
  }
}
