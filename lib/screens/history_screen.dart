import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/history_screen/history_card.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  // Dropdown state
  String selectedRange = 'This Month';
  bool dropdownOpen = false;

  // example values for different ranges (to be swapped with real data later)
  final Map<String, String> savedThis = {
    'This Month': '2,300',
    'This quarter': '7,800',
    'This half-yearly': '9,600',
    'This year': '12,500',
  };

  // map to create friendly wording in the summary card
  final Map<String, String> rangeWord = {
    'This Month': 'month',
    'This quarter': 'quarter',
    'This half-yearly': 'half-year',
    'This year': 'year',
  };

  // dropdown options in the order you wanted
  final List<String> options = [
    'This Month',
    'This quarter',
    'This half-yearly',
    'This year',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned.fill(child: Background()),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color.fromARGB(0, 240, 240, 240),
              title: const Text(
                "Saving History",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  children: [
                    // Tappable row that toggles the dropdown
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          dropdownOpen = !dropdownOpen;
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Text(selectedRange),
                          const SizedBox(width: 6),
                          // rotate the caret when open
                          AnimatedRotation(
                            turns: dropdownOpen ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Animated dropdown area (expands/collapses neatly)
                    AnimatedSize(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeInOut,
                      child: ClipRect(
                        child: dropdownOpen
                            ? Container(
                                margin: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(10, 0, 0, 0),
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: options.map((opt) {
                                    final bool selected = opt == selectedRange;
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedRange = opt;
                                          dropdownOpen = false;
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              opt,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: selected
                                                    ? FontWeight.w700
                                                    : FontWeight.w400,
                                                color: selected
                                                    ? const Color(0xFF03969D)
                                                    : Colors.black,
                                              ),
                                            ),
                                            if (selected)
                                              const Icon(
                                                Icons.check,
                                                size: 18,
                                                color: Color(0xFF03969D),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Responsive summary card (uses selectedRange + savedThis map)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF03969D),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double maxWidth = constraints.maxWidth;
                          double graphWidth = maxWidth * 0.32;
                          if (graphWidth < 72) graphWidth = 72;
                          if (graphWidth > 140) graphWidth = 140;

                          final String savedValue =
                              savedThis[selectedRange] ??
                              savedThis['This Month']!;

                          final String rangeFriendly =
                              rangeWord[selectedRange] ?? 'period';

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total saved this $rangeFriendly',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      savedValue,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    const Divider(
                                      color: Colors.white,
                                      thickness: 1.0,
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Total saved overall',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "12,500",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 12),

                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 56,
                                  maxWidth: graphWidth,
                                  maxHeight: 120,
                                  minHeight: 56,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Image.asset(
                                    "assets/history/graph_history.png",
                                    width: graphWidth - 12,
                                    height: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),
                    HistoryCard(
                      amount: "+ \u{20B9}500",
                      date: "Aug 15, 2025",
                      historyText: "Cancelled unused subscription",
                    ),
                    const SizedBox(height: 10),
                    HistoryCard(
                      amount: "+ \u{20B9}500",
                      date: "Aug 15, 2025",
                      historyText: "Cooked at home instead of ordering foods",
                    ),
                    const SizedBox(height: 10),
                    HistoryCard(
                      amount: "+ \u{20B9}500",
                      date: "Aug 15, 2025",
                      historyText: "Lower internet bill after plan switch",
                    ),
                    const SizedBox(height: 10),
                    HistoryCard(
                      amount: "+ \u{20B9}500",
                      date: "Aug 15, 2025",
                      historyText: "Saved from using coupon",
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
