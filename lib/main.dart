import 'package:ekonomi_new/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(backgroundColor: Colors.transparent, body: Homescreen()),
      theme: ThemeData(
        primaryColor: Color(0xFF03969D),
      ),
    );
  }
}
