import 'package:flutter/material.dart';

class Alertitem extends StatelessWidget {
  final String amount;
  final String heading;
  final String date;
  final String due;
  
  const Alertitem({
    super.key,
    required this.amount,
    required this.date,
    required this.heading,
    required this.due,
    
  });
  
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(255, 215, 68, 1),
                  ),
                  child: Icon(
                    Icons.error_sharp,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      due,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.45),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                      '₹ $amount',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                SizedBox(height: 5),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 0, 0, 0.45),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
