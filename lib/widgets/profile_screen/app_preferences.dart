import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPreferences extends StatefulWidget {
  const AppPreferences({super.key});

  @override
  State<AppPreferences> createState() => _AppPreferencesState();
}

class _AppPreferencesState extends State<AppPreferences> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.black,
                    weight: 40,
                  ),
                  const SizedBox(width: 20),
                  Text("Dark Mode", style: TextStyle(fontSize: 16)),
                ],
              ),
              // Toggle
              SizedBox(
                height: 25,
                width: 50,
                child: CupertinoSwitch(
                  activeTrackColor: Color(0xFF03969D),
                  value: isSwitched,
                  onChanged: (bool newValue) {
                    setState(() {
                      isSwitched = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.language, color: Colors.black, weight: 40),
                  const SizedBox(width: 20),
                  Text("Language", style: TextStyle(fontSize: 16)),
                ],
              ),
              // Toggle
              SizedBox(height: 25, width: 50, child: Text("English")),
            ],
          ),
        ],
      ),
    );
  }
}
