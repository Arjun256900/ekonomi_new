import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/profile_screen/app_preferences.dart';
import 'package:ekonomi_new/widgets/profile_screen/general_preferences.dart';
import 'package:ekonomi_new/widgets/profile_screen/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              backgroundColor: Colors.transparent,
              title: const Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ProfileCard(
                            name: "John Doe",
                            email: "johndoe@gmail.com",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // group 1
                    GeneralPreferences(),
                    const SizedBox(height: 25),
                    const Text(
                      "App preferences",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(height: 15),
                    // group 2
                    AppPreferences(),
                    const SizedBox(height: 25),
                    Text(
                      "Help and support",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Help & FAQs',
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Contact support",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Terms and privacy',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
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
}
