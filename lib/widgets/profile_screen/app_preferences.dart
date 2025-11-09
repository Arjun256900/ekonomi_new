import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPreferences extends StatefulWidget {
  const AppPreferences({super.key});

  @override
  State<AppPreferences> createState() => _AppPreferencesState();
}

class _AppPreferencesState extends State<AppPreferences> {
  bool isSwitched = false;
  String selectedLanguage = "English"; // ✅ State for language

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Dark Mode Row
          GestureDetector(
            onTap: () {
              setState(() {
                isSwitched = !isSwitched; // ✅ Toggle if row is tapped
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.dark_mode_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    const SizedBox(width: 20),
                    Text("Dark Mode", style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(
                  height: 25,
                  width: 50,
                  child: CupertinoSwitch(
                    activeTrackColor:Theme.of(context).primaryColor,
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
          ),

          const SizedBox(height: 18),

          // Language Row
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Choose Language"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text("English"),
                        onTap: () {
                          Navigator.pop(context);
                          setState(
                            () => selectedLanguage = "English",
                          ); // ✅ update
                        },
                      ),
                      ListTile(
                        title: Text("Spanish"),
                        onTap: () {
                          Navigator.pop(context);
                          setState(
                            () => selectedLanguage = "Spanish",
                          ); // ✅ update
                        },
                      ),
                      ListTile(
                        title: Text("French"),
                        onTap: () {
                          Navigator.pop(context);
                          setState(
                            () => selectedLanguage = "French",
                          ); // ✅ update
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.language, color: Colors.black, size: 30),
                    const SizedBox(width: 20),
                    Text("Language", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Text(
                  selectedLanguage,
                  style: TextStyle(fontSize: 16),
                ), // ✅ show selected language
              ],
            ),
          ),
        ],
      ),
    );
  }
}
