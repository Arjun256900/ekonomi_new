import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final List<String> filters;
  final String? selectedFilter;
  final ValueChanged<String>? onFilterChanged;

  const FilterWidget({
    super.key,
    required this.filters,
    this.selectedFilter,
    this.onFilterChanged,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selectedFilter ?? widget.filters[0];
  }

  @override
  void didUpdateWidget(covariant FilterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update selected if parent changes it
    if (widget.selectedFilter != null && widget.selectedFilter != selected) {
      selected = widget.selectedFilter!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.filters.map((filter) {
          final bool isSelected = selected == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = filter;
                });
                if (widget.onFilterChanged != null) {
                  widget.onFilterChanged!(filter);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color.fromRGBO(6, 138, 147, 1)
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
