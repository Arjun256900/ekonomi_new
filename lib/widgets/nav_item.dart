import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback ontap;

  const NavItem({
    required this.icon,
    required this.label,
    required this.ontap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: selected
                ? Colors.white
                : const Color.fromRGBO(255, 255, 255, 0.4),
            size: 30,
          ),
          Text(
            label,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : const Color.fromRGBO(255, 255, 255, 0.4),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
