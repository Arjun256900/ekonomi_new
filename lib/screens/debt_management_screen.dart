import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/add_new_debt.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/general/filter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebtManagementScreen extends StatefulWidget {
  const DebtManagementScreen({super.key});

  @override
  State<DebtManagementScreen> createState() => _DebtManagementScreenState();
}

class _DebtManagementScreenState extends State<DebtManagementScreen> {
  
  static double get _cardRadius => 12.0;

  // sample data
  final List<_DebtItem> _items = const [
    _DebtItem(
      bankName: 'HDFC Bank',
      subtitle: 'Balance',
      amount: '₹ 1,00,000',
      interest: '12%',
      date: 'September 5',
      iconData: Icons.account_balance,
      iconBg: Color(0xFFFEECEC),
    ),
    _DebtItem(
      bankName: 'ICICI Bank',
      subtitle: 'Balance',
      amount: '₹ 65,000',
      interest: '10%',
      date: 'October 15',
      iconData: Icons.account_balance_wallet,
      iconBg: Color(0xFFFFF3E6),
    ),
    _DebtItem(
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
    final Color _teal= Theme.of(context).primaryColor;
    final mq = MediaQuery.of(context);
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
                  "Saving History",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildFilterChips(),
                    // FilterWidget(filters: ['All', 'Loans', 'Cards']),
                    const SizedBox(height: 12),
                    _buildSummaryCard(),
                    const SizedBox(height: 12),
                    _buildProgressCard(),
                    const SizedBox(height: 12),
                    // list header & list
                    Expanded(
                      child: ListView.separated(
                        itemCount: _items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final it = _items[index];
                          return _debtTile(it);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildBottomButtons(mq),
                    const SizedBox(height: 16),
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
    final Color _teal= Theme.of(context).primaryColor;
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

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _summaryColumn('Total Debt', '₹2,45,000'),
          const SizedBox(width: 10),
          Expanded(child: _summaryColumn('Monthly Payment', '₹13,500')),
          const SizedBox(width: 10),
          _summaryColumn('Interest', '12.5%'),
        ],
      ),
    );
  }

  Widget _summaryColumn(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    final Color _teal= Theme.of(context).primaryColor;
    const progressPercent = 0.28; // 28%
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // circular progress
          SizedBox(
            width: 84,
            height: 84,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 84,
                  height: 84,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 8,
                    valueColor: AlwaysStoppedAnimation(Colors.grey.shade200),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: 84,
                  height: 84,
                  child: CircularProgressIndicator(
                    value: progressPercent,
                    strokeWidth: 8,
                    valueColor:  AlwaysStoppedAnimation(_teal),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(progressPercent * 100).round()}%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          // progress bar and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Repayment Progress',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progressPercent,
                    minHeight: 12,
                    backgroundColor: Colors.grey.shade300,
                    valueColor:  AlwaysStoppedAnimation(_teal),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _debtTile(_DebtItem it) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.98),
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // icon / bank logo placeholder
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: it.iconBg ?? Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(it.iconData, size: 28, color: Colors.black54),
          ),
          const SizedBox(width: 12),
          // bank name & subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  it.bankName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      it.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      it.interest,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // amount & date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                it.amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                it.date,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(MediaQueryData mq) {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            'Add Debt',
            onTap: () {
              Navigator.of(
                context,
              ).push(CupertinoPageRoute(builder: (context) => AddNewDebt()));
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: _actionButton('Set Reminder', onTap: () {})),
        const SizedBox(width: 10),
        Expanded(child: _actionButton('View Insights', onTap: () {})),
      ],
    );
  }

  Widget _actionButton(String label, {required VoidCallback onTap}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 17),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
      onPressed: onTap,
      child: Text(label),
    );
  }
}

class _DebtItem {
  final String bankName;
  final String subtitle;
  final String amount;
  final String interest;
  final String date;
  final IconData iconData;
  final Color? iconBg;

  const _DebtItem({
    required this.bankName,
    required this.subtitle,
    required this.amount,
    required this.interest,
    required this.date,
    required this.iconData,
    this.iconBg,
  });
}
