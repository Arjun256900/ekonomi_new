import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CouponCard extends StatefulWidget {
  final String offer;
  final String name;
  final String valid_amount;
  final String till_date;
  final bool isNew;

  const CouponCard({
    super.key,
    required this.offer,
    required this.name,
    required this.valid_amount,
    required this.till_date,
    this.isNew = true,
  });

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        // Main Coupon Card
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(226, 97, 71, 1),
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(8),
                strokeWidth: 1.5,
                dashPattern: [6, 6],
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Container(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      "assets/coupons/${widget.name.toLowerCase()}.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Offer text
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Text(
                          "${widget.offer}% OFF on ${widget.name} orders",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "valid on orders above ${widget.valid_amount}, till ${widget.till_date}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Apply Button
                  GestureDetector(
                    onTap: () {
                      // yet to add
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: 79,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(39, 124, 216, 1),
                        borderRadius: BorderRadius.circular(2.64),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //  "NEW" Badge (diagonal)
        if (widget.isNew)
          Positioned(
            top: 1,
            right: -10, // shift outside so it aligns diagonally
            child: Transform.rotate(
              angle: 170.0, // 45° rotation
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Text(
                  "New",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
