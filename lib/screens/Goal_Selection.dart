import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/Permission_Selection.dart';
import 'package:ekonomi_new/widgets/Goal_Onboard/GoalCard.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoalSelection extends StatefulWidget {
  const GoalSelection({super.key});

  @override
  State<GoalSelection> createState() => _GoalSelectionState();
}

class _GoalSelectionState extends State<GoalSelection> {
  final Set<int> selectedIndexes = {0, 3};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: BackButtonLeading(),
              centerTitle: true,
              title: Text(
                "What are your goals?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(builder: (context) => PermissionSelection(),))  ;
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Color(0xFF1FB6B2),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    const Text(
                      "Select your top priorities to personalize your experience.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF9AA7B5), fontSize: 14),
                    ),

                    const SizedBox(height: 24),

                    // Grid
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.05,
                        children: [
                          GoalCard(
                            icon: Icons.savings,
                            title: "Save More",
                            description: "Build your savings for the future.",
                            isSelected: selectedIndexes.contains(0),
                            onTap: () => toggle(0),
                          ),
                          GoalCard(
                            icon: Icons.credit_card_off,
                            title: "Reduce Debt",
                            description: "Pay off loans and credit cards.",
                            isSelected: selectedIndexes.contains(1),
                            onTap: () => toggle(1),
                          ),
                          GoalCard(
                            icon: Icons.receipt_long,
                            title: "Track Expenses",
                            description: "See where your money is going.",
                            isSelected: selectedIndexes.contains(2),
                            onTap: () => toggle(2),
                          ),
                          GoalCard(
                            icon: Icons.trending_up,
                            title: "Invest",
                            description: "Grow your retirement fund.",
                            isSelected: selectedIndexes.contains(3),
                            onTap: () => toggle(3),
                          ),
                          GoalCard(
                            icon: Icons.house,
                            title: "Big Purchase",
                            description: "Save for a car, house, or trip.",
                            isSelected: selectedIndexes.contains(4),
                            onTap: () => toggle(4),
                          ),
                          GoalCard(
                            icon: Icons.pie_chart,
                            title: "Budgeting",
                            description: "Stick to a monthly spending plan.",
                            isSelected: selectedIndexes.contains(5),
                            onTap: () => toggle(5),
                          ),
                          GoalCard(
                            icon: Icons.add,
                            title: "Add Your Own",
                            description: "Define a custom goal.",
                            isSelected: selectedIndexes.contains(6),
                            onTap: () => toggle(6),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1FB6B2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => PermissionSelection(),)) ; 
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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

  void toggle(int index) {
    setState(() {
      selectedIndexes.contains(index)
          ? selectedIndexes.remove(index)
          : selectedIndexes.add(index);
    });
  }
}
