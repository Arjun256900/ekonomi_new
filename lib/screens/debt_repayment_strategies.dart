import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

enum Strategy { snowball, avalanche }

class DebtRepaymentStrategies extends StatefulWidget {
  const DebtRepaymentStrategies({super.key});

  @override
  State<DebtRepaymentStrategies> createState() =>
      _DebtRepaymentStrategiesState();
}

class _DebtRepaymentStrategiesState extends State<DebtRepaymentStrategies> {
  Strategy _selected = Strategy.snowball;
  double _extraMonthly = 32000;
  final NumberFormat _currency = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
  );

  // Example month labels (May - Sep)
  final List<String> _months = ['May', 'Jun', 'Jul', 'Aug', 'Sep'];

  // Example baseline and strategy data (replace with real model)
  List<double> _baselineData = [5000, 5000, 5000, 7000, 6000];
  List<double> _snowballData = [1000, 2000, 7000, 15000, 25000];
  List<double> _avalancheData = [1200, 1800, 6000, 8000, 22000];

  List<double> get _strategyData =>
      _selected == Strategy.snowball ? _snowballData : _avalancheData;

  String get _estimatedPayoff => '24 Months';
  String get _totalInterest => _selected == Strategy.snowball
      ? _currency.format(32000)
      : _currency.format(28000);

  @override
  void initState() {
    super.initState();
    _applySimulation(); // seed simulated curve
  }

  // Demo simulation: scale values by extraMonthly. Replace with real amortization.
  void _applySimulation() {
    final factor = (_extraMonthly / 32000).clamp(0.2, 3.0);
    setState(() {
      _snowballData = [
        1000,
        2000,
        7000,
        15000,
        25000,
      ].map((v) => (v / factor).clamp(0.0, double.infinity)).toList();
      _avalancheData = [
        1200,
        1800,
        6000,
        8000,
        22000,
      ].map((v) => (v / factor).clamp(0.0, double.infinity)).toList();
      // baseline left static-ish for demo
      _baselineData = [5000, 5000, 5000, 7000, 6000];
    });
  }

  void _onSliderChanged(double val) {
    _extraMonthly = val;
    _applySimulation();
  }

  void _selectStrategy(Strategy s) {
    setState(() {
      _selected = s;
    });
    // recompute with same extra value
    _applySimulation();
  }

  void _applyStrategy() {
    // Hook: replace this with BLoC / service call
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_selected == Strategy.snowball ? 'Snowball' : 'Avalanche'} applied — simulated extra ${_currency.format(_extraMonthly)}',
        ),
      ),
    );
  }

  LineChartBarData _buildLine(List<double> data, {required Color color}) {
    return LineChartBarData(
      spots: data
          .asMap()
          .entries
          .map((e) => FlSpot(e.key.toDouble(), e.value))
          .toList(),
      isCurved: true,
      barWidth: 2.5,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final maxY =
        ([..._baselineData, ..._strategyData].reduce((a, b) => a > b ? a : b) *
        1.2);

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
                backgroundColor: const Color.fromARGB(0, 240, 240, 240),
                elevation: 0,
                title: const Text(
                  "Repayment strategies",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    // Strategy cards row
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectStrategy(Strategy.snowball),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: _selected == Strategy.snowball
                                    ? const Color(0xFF6DCFA4)
                                    : const Color(0xFFDBF4E9),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: _selected == Strategy.snowball
                                    ? [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Center(
                                    child: Text(
                                      "Snowball",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: _selected == Strategy.snowball
                                            ? Colors.black
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pay off your smallest balances quickly to build motivation.",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          "Estimated Payoff Time: 24 Months",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Total Interest Paid: ₹32,000",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectStrategy(Strategy.avalanche),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: _selected == Strategy.avalanche
                                    ? const Color(0xFFF7E082)
                                    : const Color(0xFFFFF4D9),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: _selected == Strategy.avalanche
                                    ? [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Center(
                                    child: Text(
                                      "Avalanche",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: _selected == Strategy.avalanche
                                            ? Colors.black
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pay off your Highest interest rate first, cost-saving.",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          "Estimated Payoff Time: 24 Months",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Total Interest Paid: ₹28,000",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Chart card
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              // Chart area
                              Expanded(
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: false,
                                    ),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {
                                            final idx = value.toInt();
                                            if (idx >= 0 &&
                                                idx < _months.length) {
                                              return Text(
                                                _months[idx],
                                                style: TextStyle(fontSize: 12),
                                              );
                                            }
                                            return const Text('');
                                          },
                                          interval: 1,
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {
                                            if (value == 0)
                                              return const Text(
                                                '0',
                                                style: TextStyle(fontSize: 10),
                                              );
                                            if (value >= 1000) {
                                              return Text(
                                                '${(value / 1000).round()}k',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                              );
                                            }
                                            return Text(
                                              value.toStringAsFixed(0),
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            );
                                          },
                                          reservedSize: 40,
                                          interval: maxY / 4,
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                    ),
                                    minY: 0,
                                    maxY: maxY,
                                    lineBarsData: [
                                      // baseline (black)
                                      _buildLine(
                                        _baselineData,
                                        color: Colors.black,
                                      ),
                                      // strategy line (blue)
                                      _buildLine(
                                        _strategyData,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Slider + amount
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Simulate Extra Monthly Payments',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Text(
                                    _currency.format(_extraMonthly),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Slider(
                                min: 0,
                                max: 50000,
                                divisions: 100,
                                value: _extraMonthly,
                                onChanged: (v) =>
                                    setState(() => _onSliderChanged(v)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Footer stats + CTA
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Estimated Payoff Time',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _estimatedPayoff,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Interest Paid',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _totalInterest,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Apply button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _applyStrategy,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Apply Strategy',
                          style: TextStyle(fontSize: 16),
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
}
