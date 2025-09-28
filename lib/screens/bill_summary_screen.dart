import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:flutter/material.dart';

// A simple data model for the items in the bill
class BillItem {
  final String name;
  final double price;
  final bool isGoodDeal;
  final double amountSavedOrLost;

  BillItem({
    required this.name,
    required this.price,
    required this.isGoodDeal,
    required this.amountSavedOrLost,
  });
}

// A simple data model for the alternative items
class AlternativeItem {
  final String imagePath;
  final String name;
  final double price;
  final double amountSaved;

  AlternativeItem({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.amountSaved,
  });
}

class BillSummaryScreen extends StatefulWidget {
  const BillSummaryScreen({super.key});

  @override
  State<BillSummaryScreen> createState() => _BillSummaryScreenState();
}

class _BillSummaryScreenState extends State<BillSummaryScreen> {
  // Define the primary color for reuse
  static const Color primaryColor = Color.fromRGBO(6, 139, 147, 1);
  int _selectedBillIndex = 0;

  final List<String> billThumbnails = [
    'assets/opportunities/bill.png',
    'assets/opportunities/bill.png',
    'assets/opportunities/bill.png',
    'assets/opportunities/bill.png',
  ];

  final List<BillItem> billItems = [
    BillItem(
      name: '"Organic Almonds 1kg"',
      price: 520,
      isGoodDeal: true,
      amountSavedOrLost: 40,
    ),
    BillItem(
      name: '"Imported Chips"',
      price: 320,
      isGoodDeal: false,
      amountSavedOrLost: -100,
    ),
  ];

  final List<AlternativeItem> alternativeItems = [
    AlternativeItem(
      imagePath: 'assets/opportunities/coffee.png',
      name: 'Local Almonds 1kg',
      price: 450,
      amountSaved: 70,
    ),
    AlternativeItem(
      imagePath: 'assets/opportunities/coffee.png',
      name: 'Budget Chips Combo',
      price: 250,
      amountSaved: 70,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: const BackButtonLeading(),
            title: const Text(
              "Your Bill Summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bill thumbnails section
                _buildBillThumbnails(),
                const SizedBox(height: 24),

                // Bill items section
                ...billItems.map((item) => _buildItemCard(item)).toList(),
                const SizedBox(height: 24),

                // Alternatives section
                const Text(
                  'Alternatives',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...alternativeItems
                    .map((item) => _buildAlternativeCard(item))
                    .toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget for the horizontal list of bill thumbnails
  Widget _buildBillThumbnails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bill no : 1',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 70,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: billThumbnails.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedBillIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedBillIndex = index;
                        });
                      },
                      child: Container(
                        width: 70,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(color: primaryColor, width: 2.5)
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        // You can use Image.asset or Image.network here
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            billThumbnails[index],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Text(
                "Next",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget for displaying a single item from the bill
  Widget _buildItemCard(BillItem item) {
    final dealColor = item.isGoodDeal ? Colors.green : Colors.red;
    final dealIcon = item.isGoodDeal
        ? Icons.thumb_up_rounded
        : Icons.thumb_down_rounded;
    final dealText = item.isGoodDeal ? 'Good Deal' : 'Bad Deal';
    final savedText = item.isGoodDeal ? 'Saved' : 'Loss';
    final savedAmount = item.isGoodDeal
        ? '₹${item.amountSavedOrLost.toInt()}'
        : '- ₹${item.amountSavedOrLost.abs().toInt()}';

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    dealText,
                    style: TextStyle(
                      color: dealColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(dealIcon, color: dealColor, size: 16),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Prize : ₹${item.price.toInt()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '($savedText) $savedAmount',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for displaying a single alternative item
  Widget _buildAlternativeCard(AlternativeItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            // You can use Image.asset or Image.network here
            child: Image.asset(
              item.imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Price: ₹${item.price.toInt()}  (Saved) ₹${item.amountSaved.toInt()}',
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Buy Now'),
          ),
        ],
      ),
    );
  }
}
