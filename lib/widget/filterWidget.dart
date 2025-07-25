import 'package:flutter/material.dart';

class Filterwidget extends StatefulWidget {
  List<String> filters;
  Filterwidget({super.key,required this.filters});

  @override
  State<Filterwidget> createState() => _FilterwidgetState();
}

class _FilterwidgetState extends State<Filterwidget> {
  late List<String> filters;
  String selected ='';

  @override
  void initState() {
    super.initState();
    filters = widget.filters;
    selected = filters[0];
  }

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
