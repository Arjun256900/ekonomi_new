import 'package:flutter/material.dart';

class SpendingLegend extends StatelessWidget {
  // for each legend's label
  final List<String> labels;

  /// Corresponding percentage values (this needs to be matched according to the pie chart)
  final List<double> percentages;

  /// Colors for each category bar.
  final List<Color> colors;

  const SpendingLegend({
    Key? key,
    required this.labels,
    required this.percentages,
    required this.colors,
  }) : assert(
         labels.length == percentages.length && labels.length == colors.length,
         'Labels, percentages, and colors must have the same length',
       ),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 16 / 9,
      ),
      itemCount: labels.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 10,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment(-1.0, -0.7), // left, above center
                        child: Text(
                          labels[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment(1.0, 0.7), // right, below center
                        child: Text(
                          '${percentages[index].toInt()}%',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
