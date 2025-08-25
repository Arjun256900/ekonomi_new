import 'package:ekonomi_new/background/backGround.dart';
import 'package:flutter/material.dart';

class PremiumPopup extends StatefulWidget {
  const PremiumPopup({super.key});

  @override
  State<PremiumPopup> createState() => _PremiumPopupState();
}

class _PremiumPopupState extends State<PremiumPopup> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 20,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17.0),
          ),

          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // background
              ClipRRect(
                borderRadius: BorderRadius.circular(17.0),
                child: Background(),
              ),

              // main card
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40), // space for the diamond avatar
                    Text(
                      "Unlock Premium",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Elevate Your Finances",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Track investments in real-time, get priority alerts, and enjoy an ad-free experience",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 20),

                    PremiumCard(
                      title: "Premium",
                      backgroundColor: Colors.white,
                      points: [
                        "Smart financial suggestions",
                        "Track your investments real-time",
                        "Ad-free premium experience",
                      ],
                    ),
                    SizedBox(height: 12),

                    PremiumCard(
                      title: "7-Days Free Trial",
                      backgroundColor: Theme.of(context).primaryColor,
                      points: [
                        "Basic spending insights",
                        "Manual goal tracking",
                        "Manual goal tracking",
                      ],
                    ),
                    Spacer(),

                    GestureDetector(
                      onTap: () {
                        // yet to add
                      },
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Get Started Today!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 💎 Diamond Avatar (placed above the card)
              Positioned(
                top: -30,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(3), // border thickness
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFDDE44), // yellow
                          Color(0xFFA3640E), // brown
                          Color(0xFFFDDE44),
                          Color(0xFFA3640E),
                          Color(0xFFFDDE44),
                          Color(0xFFA3640E),
                        ],
                        stops: [0.0, 0.1971, 0.375, 0.5721, 0.7548, 0.9279],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Text("💎", style: TextStyle(fontSize: 40)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  final String title;
  final List<String> points;
  final Color backgroundColor;

  const PremiumCard({
    super.key,
    required this.title,
    required this.points,
    this.backgroundColor = const Color.fromARGB(
      255,
      255,
      255,
      255,
    ), // default grey[100]
  });

  @override
  Widget build(BuildContext context) {
    final String icon = title != "Premium" ? "🔒" : "🔐";
    final Color ofText = title != "Premium" ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Text(icon, style: TextStyle(fontSize: 18)),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: ofText),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Build points dynamically
          Column(
            children: points.map((point) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 4.5,
                      backgroundColor: title != "Premium"
                          ? const Color.fromARGB(189, 255, 255, 255)
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(point, style: TextStyle(color: ofText)),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
