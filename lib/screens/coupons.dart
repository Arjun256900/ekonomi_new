import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/coupons/Soon_card.dart';
import 'package:ekonomi_new/widgets/coupons/coupon_card.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:flutter/material.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: BackButtonLeading(),
            backgroundColor: Colors.transparent,
            title: Text("Coupons"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Coupons",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                // My Coupons List
                Column(
                  children: [
                    CouponCard(
                      offer: "20",
                      name: "Swiggy",
                      valid_amount: "299",
                      till_date: "Aug 15",
                    ),
                    const SizedBox(height: 10),
                    CouponCard(
                      offer: "20",
                      name: "Flipkart",
                      valid_amount: "299",
                      till_date: "Aug 15",
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Comming Soon",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                SoonCard(offer: "250", onWhat: "electricity bill"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
