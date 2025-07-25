import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionItem {
  final String title, subtitle;
  final IconData icon;
  final bool filled;
  final Widget navigation;
  ActionItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.filled,
    required this.navigation,
  });
}

class ActionCard extends StatelessWidget {
  final ActionItem item;
  const ActionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {Navigator.of(context,).push(CupertinoPageRoute(builder: (context) => item.navigation))},
      child: Card(
        color: item.filled ? Color(0xFF048B94) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: item.filled ? 4 : 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: item.filled ? Colors.white : Colors.grey[200],
                child: Icon(
                  item.icon,
                  color: item.filled ? Color(0xFF048B94) : Color(0xFF048B94),
                ),
              ),
              Spacer(),
              Text(
                item.title,
                style: TextStyle(
                  color: item.filled ? Colors.white : Color(0xFF048B94),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                item.subtitle,
                style: TextStyle(
                  color: item.filled ? Colors.white : Colors.black54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
