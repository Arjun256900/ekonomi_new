import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:flutter/material.dart';

class OcassionPlannerScreen extends StatefulWidget {
  const OcassionPlannerScreen({super.key});

  @override
  State<OcassionPlannerScreen> createState() => _OcassionPlannerScreenState();
}

class _OcassionPlannerScreenState extends State<OcassionPlannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: backButtonLeading(),
              title: Text(
                "Occasional Planner",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
