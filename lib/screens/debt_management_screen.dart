import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/add_new_debt.dart';
import 'package:ekonomi_new/widgets/debt_screen/bottom_buttons.dart';
import 'package:ekonomi_new/widgets/debt_screen/debt_item.dart';
import 'package:ekonomi_new/widgets/debt_screen/debt_tile.dart';
import 'package:ekonomi_new/widgets/debt_screen/loan_card.dart';
import 'package:ekonomi_new/widgets/debt_screen/progress_card.dart';
import 'package:ekonomi_new/widgets/debt_screen/summary_card.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DebtManagementScreen extends StatefulWidget {
  const DebtManagementScreen({super.key});

  @override
  State<DebtManagementScreen> createState() => _DebtManagementScreenState();
}

class _DebtManagementScreenState extends State<DebtManagementScreen> {
  // sample data
  final List<DebtItem> _items = const [
    DebtItem(
      bankName: 'HDFC Bank',
      subtitle: 'Balance',
      amount: '₹ 1,00,000',
      interest: '12%',
      date: 'September 5',
      iconData: Icons.account_balance,
      iconBg: Color(0xFFFEECEC),
    ),
    DebtItem(
      bankName: 'ICICI Bank',
      subtitle: 'Balance',
      amount: '₹ 65,000',
      interest: '10%',
      date: 'October 15',
      iconData: Icons.account_balance_wallet,
      iconBg: Color(0xFFFFF3E6),
    ),
    DebtItem(
      bankName: 'SBI',
      subtitle: 'Balance',
      amount: '₹ 50,000',
      interest: '9%',
      date: 'November 2',
      iconData: Icons.account_balance_outlined,
      iconBg: Color(0xFFEAF6FF),
    ),
  ];

  // current selected filter chip index
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromRGBO(6, 139, 147, 1);
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
                  "Debt management",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _selectedFilter == 0
                    ? Column(
                        children: [
                          const SizedBox(height: 8),
                          _buildFilterChips(),
                          const SizedBox(height: 12),
                          SummaryCard(),
                          const SizedBox(height: 12),
                          ProgressCard(progressPercent: 0.28),
                          const SizedBox(height: 12),
                          // list header & list
                          Expanded(
                            child: ListView.separated(
                              itemCount: _items.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final it = _items[index];
                                return DebtTile(it: it);
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          BottomButtons(),
                          const SizedBox(height: 16),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 8),
                          _buildFilterChips(),
                          const SizedBox(height: 14),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 7,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: LoanCard(),
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) => AddNewDebt(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    "Add debt",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
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

  Widget _buildFilterChips() {
    final Color _teal = Theme.of(context).primaryColor;
    final labels = ['All', 'Loans', 'Cards'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(labels.length, (i) {
        final selected = i == _selectedFilter;
        return Padding(
          padding: EdgeInsets.only(right: i == labels.length - 1 ? 0 : 8),
          child: GestureDetector(
            onTap: () => setState(() => _selectedFilter = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? _teal : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: selected
                    ? null
                    : Border.all(color: Colors.grey.shade300),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: _teal.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                labels[i],
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
