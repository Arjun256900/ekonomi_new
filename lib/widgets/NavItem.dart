import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  Icon icon;
  final String lable;
  NavItem({super.key, required this.icon, required this.lable});

  @override
  Widget build(BuildContext context) {
    return Column(children: [icon, SizedBox(height: 5), Text(lable)]);
  }
}
