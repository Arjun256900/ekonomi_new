import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/Global/Spendings_bloc.dart';
import 'package:ekonomi_new/screens/add_new_spending.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/general/add_btn_appbar.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ekonomi_new/widgets/spending_screen/spending_chart.dart';
import 'package:ekonomi_new/widgets/spending_screen/spending_legend.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
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
                backgroundColor: Colors.transparent,
                title: Text(
                  "Spending",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                // actions: [
                //   AddBtnAppbar(
                //     ontap: () {
                //       Navigator.of(context).push(
                //         CupertinoPageRoute(
                //           builder: (context) => AddNewSpending(),
                //         ),
                //       );
                //     },
                //     title: "Add",
                //   ),
                // ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ValueListenableBuilder<Map<String, double>>(
                  valueListenable: SpendingsGlobal().categoryTotalsNotifier,
                  builder: (context, categoryMap, _) {
                    // extract values in your desired order
                    final bills = categoryMap['bills'] ?? 0;
                    final travel = categoryMap['travel'] ?? 0;
                    final food = categoryMap['food'] ?? 0;
                    final others = categoryMap['others'] ?? 0;

                    // total for display
                    final total = SpendingsGlobal().calculateTotalSum();
                    final percentages = SpendingsGlobal()
                        .getCategoryPercentages();
                    final billPercentage = percentages['bills'] ?? 0;
                    final TravelPercentage = percentages['travel'] ?? 0;
                    final FoodPercentage = percentages['food'] ?? 0;
                    final OthersPercentage = percentages['others'] ?? 0;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              FilterWidget(
                                filters: [
                                  'This week',
                                  'This Month',
                                  'Jun',
                                  'Aug',
                                ],
                              ),
                              const SizedBox(height: 40),

                              /// 🔥 Dynamic chart values
                              SpendingChart(
                                values: [
                                  billPercentage,
                                  TravelPercentage,
                                  FoodPercentage,
                                  OthersPercentage,
                                ],
                                colors: const [
                                  Color(0xFF00A896), // Bills
                                  Color(0xFFF76C6C), // Travel
                                  Color(0xFFF9A826), // Food
                                  Color(0xFF5267DF), // Others
                                ],
                              ),

                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total spending',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "₹ ${total.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        /// 🔥 Dynamic legend
                        SpendingLegend(
                          labels: ['Bills', 'Travel', 'Food', 'Others'],
                          percentages: [
                            billPercentage,
                            TravelPercentage,
                            FoodPercentage,
                            OthersPercentage,
                          ],
                          colors: const [
                            Color(0xFF00A896),
                            Color(0xFFF76C6C),
                            Color(0xFFF9A826),
                            Color(0xFF5267DF),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
