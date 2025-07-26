import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widget/AlertDash.dart';
import 'package:flutter/material.dart';

import 'package:ekonomi_new/widget/ActionGrid.dart';
import 'package:ekonomi_new/widget/NavItem.dart';
import 'package:ekonomi_new/widget/SummaryCard.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  static const Color primaryColor = Color.fromRGBO(6, 139, 147, 1);
  // static const Color accentColor = Color(0xFFD2911D);

  int _selectedIndex = 0;
  bool isopenAlert = false;

  // Screens for each bottom nav item
  List<Widget> get _screens => [
    HomeTab(isopenAlert: isopenAlert),
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

  void _isOpenAlerts() {
    setState(() {
      isopenAlert = !isopenAlert;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
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
                            child: GestureDetector(
                              onTap: () => _isOpenAlerts(),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.black,
                                  ),
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
                          ),
                        ],
                      ),
                    ),
                    toolbarHeight: 100,
                  )
                : null,
            body: SafeArea(child: _screens[_selectedIndex]),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: primaryColor, // ✅ This now works as intended
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NavItem(
                        icon: Icons.home,
                        label: 'Home',
                        selected: _selectedIndex == 0,
                        ontap: () => _onItemTapped(0),
                      ),
                      NavItem(
                        icon: Icons.search,
                        label: 'Search',
                        selected: _selectedIndex == 1,
                        ontap: () => _onItemTapped(1),
                      ),

                      // Center QR Button
                      GestureDetector(
                        onTap: () => _onItemTapped(2),
                        child: Container(
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
                      ),

                      NavItem(
                        icon: Icons.history,
                        label: 'History',
                        selected: _selectedIndex == 3,
                        ontap: () => _onItemTapped(3),
                      ),
                      NavItem(
                        icon: Icons.person,
                        label: 'Profile',
                        selected: _selectedIndex == 4,
                        ontap: () => _onItemTapped(4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeTab extends StatelessWidget {
  final bool isopenAlert;

  const HomeTab({super.key, required this.isopenAlert});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SummaryCard(),
            SizedBox(height: 16),
            ActionGrid(),
            SizedBox(height: 16),
            isopenAlert ? Alertdash() : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
