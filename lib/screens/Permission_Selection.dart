import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/home_screen.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PermissionSelection extends StatefulWidget {
  const PermissionSelection({super.key});

  @override
  State<PermissionSelection> createState() => _PermissionSelectionState();
}

class _PermissionSelectionState extends State<PermissionSelection> {
  bool notificationEnabled = false;
  bool smsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: Scaffold(
            appBar: AppBar(
              leading: BackButtonLeading(),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
          
                    /// Title
                    const Text(
                      "One last step",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
          
                    const SizedBox(height: 8),
          
                    const Text(
                      "We need a couple of permissions to provide you with the best experience.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(179, 0, 0, 0),
                      ),
                    ),
          
                    const SizedBox(height: 30),
          
                    /// Notification Card
                    permissionCard(
                      icon: Icons.notifications,
                      title: "Enable Notifications",
                      description:
                          "Receive alerts for payments due, unusual account activity, or when a borrowed amount is repaid.\n(Required)",
                      value: notificationEnabled,
                      onChanged: (val) {
                        setState(() {
                          notificationEnabled = val;
                        });
                      },
                    ),
          
                    const SizedBox(height: 20),
          
                    /// SMS Card
                    permissionCard(
                      icon: Icons.sms,
                      title: "Read SMS for Transactions",
                      description:
                          "Automatically detect and categorize bank transactions. Only transactional messages are read. (Optional)",
                      value: smsEnabled,
                      onChanged: (val) {
                        setState(() {
                          smsEnabled = val;
                        });
                      },
                    ),
          
                    const Spacer(),
          
                    /// Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1AA3A3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: notificationEnabled ? () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => Homescreen(),))  ;
                        } : null,
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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

  /// Permission Card Widget
  Widget permissionCard({
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF123E3E),
            child: Icon(icon, color: Colors.tealAccent),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(179, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: Colors.teal,
            inactiveThumbColor: Colors.black,
            inactiveTrackColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
