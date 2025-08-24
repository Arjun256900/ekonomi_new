import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SoonCard extends StatefulWidget {
  final String offer;
  final String onWhat;
  const SoonCard({super.key, required this.offer, required this.onWhat});

  @override
  State<SoonCard> createState() => _SoonCardState();
}

class _SoonCardState extends State<SoonCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(125, 179, 238, 1),
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(8),
            strokeWidth: 1.5,
            dashPattern: [6, 6],
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "assets/coupons/comming_soon.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "${widget.offer} on ${widget.onWhat} bill",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
