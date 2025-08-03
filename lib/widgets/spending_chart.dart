import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SpendingChart extends StatelessWidget {
  final List<double> values;
  final List<Color> colors;
  final String centerText;

  const SpendingChart({
    super.key,
    required this.values,
    required this.colors,
    this.centerText = 'Spendings',
  });

  @override
  Widget build(BuildContext context) {
    assert(
      values.length == colors.length,
      'Values and colors lists must have the same length',
    );

    final sections = List.generate(values.length, (i) {
      // final isTouched = false; // this is for tap effects
      final double radius = 35;
      return PieChartSectionData(
        color: colors[i],
        value: values[i],
        showTitle: false,
        radius: radius,
      );
    });

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 65,
              sectionsSpace: 0,
              startDegreeOffset: -90,
            ),
          ),
          // Center text
          Text(
            centerText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
