import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 255, 255, 255)
              : const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? const Color(0xFF1FB6B2) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFF1FB6B2).withOpacity(0.15)
                    : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.06),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF1FB6B2)
                    : const Color.fromARGB(179, 0, 0, 0),
                size: 20,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 0, 0, 0),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
