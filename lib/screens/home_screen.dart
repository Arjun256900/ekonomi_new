import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/chatbot_screen.dart';
import 'package:ekonomi_new/screens/history_screen.dart';
import 'package:ekonomi_new/screens/opportunities_screen.dart';
import 'package:ekonomi_new/screens/profile_screen.dart';
import 'package:ekonomi_new/screens/reminder_screen.dart';
import 'package:ekonomi_new/widgets/general/qr_camera.dart';
import 'package:ekonomi_new/widgets/home_screen/action_grid.dart';
import 'package:ekonomi_new/widgets/home_screen/nav_item.dart';
import 'package:ekonomi_new/widgets/home_screen/summary_card.dart';
import 'package:ekonomi_new/widgets/premium_dialog/premium_popup.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  static const Color primaryColor = Color.fromRGBO(6, 139, 147, 1);

  int _selectedIndex = 0;
  bool isopenAlert = false;

  @override
  void initState() {
    super.initState();
    // show popup after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPremiumPopup();
    });
  }

  void _showPremiumPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Center(
          child: Material(color: Colors.transparent, child: PremiumPopup()),
        );
      },
    );
  }

  // screens for each bottom nav item
  List<Widget> get _screens => [
    HomeTab(isopenAlert: isopenAlert),
    Center(child: Text("Search Page", style: TextStyle(fontSize: 24))),
    QrCamera(
      onImageSelected: (imageBytes) {
        // image bytes ready for backend
        print("Image selected: ${imageBytes?.lengthInBytes} bytes");
      },
    ),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: _selectedIndex == 0
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.01,
                      left: screenWidth * 0.001,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => OpportunitiesScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Image.asset("assets/home/home_explore.png"),
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => ReminderScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
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
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                // TODO
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.search),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  toolbarHeight: screenHeight * 0.06,
                )
              : null,
          body: SafeArea(child: _screens[_selectedIndex]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(CupertinoPageRoute(builder: (context) => Chatbot()));
            },
            backgroundColor: primaryColor,
            shape: CircleBorder(),
            child: Icon(Icons.chat_bubble_outline_sharp, color: Colors.white),
          ),
          bottomNavigationBar: Container(
            height: 95,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor,
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
      ],
    );
  }
}

class HomeTab extends StatelessWidget {
  final bool isopenAlert;

  const HomeTab({super.key, required this.isopenAlert});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Azeem',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
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
            ),
            SummaryCard(),
            SizedBox(height: 16),
            ActionGrid(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
