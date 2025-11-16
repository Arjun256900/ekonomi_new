import 'package:ekonomi_new/screens/debt_repayment_strategies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoanCard extends StatefulWidget {
  const LoanCard({super.key});

  @override
  State<LoanCard> createState() => _LoanCardState();
}

class _LoanCardState extends State<LoanCard> {
  static const Color primaryColor = Color.fromRGBO(6, 139, 147, 1);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ──────────────────── Header Row ────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Loan 1",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text("Type: Car Loan"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text("Outstanding balance:"),
                      SizedBox(width: screenWidth * 0.01),
                      Text("40,000", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Total interest:"),
                      SizedBox(width: screenWidth * 0.01),
                      Text("14.5%", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Next due date:"),
                      SizedBox(width: screenWidth * 0.01),
                      Text("May 10", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.02),
          Divider(),
          SizedBox(height: screenHeight * 0.015),

          // ──────────────────── Bottom Row ────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("This month: "),
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    "Paid",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              // ───────── Buttons ─────────
              Row(
                children: [
                  _styledButton("View Info"),
                  SizedBox(width: screenWidth * 0.02),
                  _styledButton("Repay"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ──────────────────── Custom Styled Button ────────────────────
  Widget _styledButton(String label) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => DebtRepaymentStrategies()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
