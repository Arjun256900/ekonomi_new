import 'package:flutter/material.dart';

class Filterwidget extends StatefulWidget {
  const Filterwidget({super.key});

  @override
  State<Filterwidget> createState() => _FilterwidgetState();
}

class _FilterwidgetState extends State<Filterwidget> {
  final List<String> filters = ['All', 'Bills', 'Overdue', 'Installments'];

  String selected = 'All';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final bool isSelected = selected == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = filter;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Color.fromRGBO(6, 138, 147, 1)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
