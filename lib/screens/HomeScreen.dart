import 'package:flutter/material.dart';

// Replace these with your real widgets
import 'package:ekonomi_new/widget/ActionGrid.dart';
import 'package:ekonomi_new/widget/ActionItem.dart';
import 'package:ekonomi_new/widget/NavItem.dart';
import 'package:ekonomi_new/widget/SummaryCard.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  static const Color primaryColor = Color(0xFF048B94);
  static const Color accentColor = Color(0xFFD2911D);

  int _selectedIndex = 0;

  // Screens for each bottom nav item
  final List<Widget> _screens = [
    HomeTab(),
    Center(child: Text("Search Page", style: TextStyle(fontSize: 24))),
    Center(child: Text("Scan Page", style: TextStyle(fontSize: 24))),
    Center(child: Text("History Page", style: TextStyle(fontSize: 24))),
    Center(child: Text("Profile Page", style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Azeem',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.notifications, color: Colors.black),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              toolbarHeight: 100,
            )
          : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor.withOpacity(0.2),
              accentColor.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(child: _screens[_selectedIndex]),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: BottomAppBar(
            color: primaryColor,
            elevation: 0,
            child: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NavItem(icon: Icons.home, label: 'Home'),
                    NavItem(icon: Icons.search, label: 'Search'),

                    // Big center QR button
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: Center(
                        child: Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.qr_code,
                            size: 28,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    NavItem(icon: Icons.history, label: 'History'),
                    NavItem(icon: Icons.person, label: 'Profile'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SummaryCard(),
          SizedBox(height: 16),
          Expanded(child: ActionGrid()),
        ],
      ),
    );
  }
}
