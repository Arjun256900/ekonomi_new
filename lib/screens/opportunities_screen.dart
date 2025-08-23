import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/opportunities_screen/quick_summary.dart';
import 'package:ekonomi_new/widgets/opportunities_screen/saving_recommendation.dart';
import 'package:flutter/material.dart';

class OpportunitiesScreen extends StatefulWidget {
  const OpportunitiesScreen({super.key});

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: BackButtonLeading(),
              backgroundColor: Colors.transparent,
              title: Text(
                "Saving Opportunities",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                children: [
                  QuickSummary(amount: "2,300"),
                  const SizedBox(height: 15),
                  SavingRecommendation(
                    buttonText: "Cancel Now",
                    recommendationTitle: "Subscriptions you rarely use",
                    recommendationDescription:
                        "You spent ₹499 on a streaming service but haven't used it in 2 months.",
                    imagePath: 'assets/opportunities/subscriptions.png',
                  ),
                  const SizedBox(height: 10),
                  SavingRecommendation(
                    buttonText: "Set Limit",
                    recommendationTitle: "High spending categories",
                    recommendationDescription:
                        "You spent 40% on Food Delivery. Cooking at home twice a week can save ~₹1,200/month.",
                    imagePath: 'assets/opportunities/food.png',
                  ),
                  const SizedBox(height: 10),
                  SavingRecommendation(
                    buttonText: "Compare Plans",
                    recommendationTitle: "Bill comparisons",
                    recommendationDescription:
                        "Your internet bill is ₹899. Other providers offer plans at ₹699. Switch to save ₹200/month",
                    imagePath: 'assets/opportunities/bill.png',
                  ),
                  const SizedBox(height: 10),
                  SavingRecommendation(
                    buttonText: "Track Coffee Spending",
                    recommendationTitle: "Shopping habits",
                    recommendationDescription:
                        "You bought 8 coffees outside. Switching to homemade could save ₹800/month",
                    imagePath: 'assets/opportunities/coffee.png',
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
