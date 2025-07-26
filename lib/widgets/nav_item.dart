import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final Icon icon;
  final String lable;
  const NavItem({super.key, required this.icon, required this.lable});

  @override
  Widget build(BuildContext context) {
    return Column(children: [icon, SizedBox(height: 5), Text(lable)]);
  }
}
