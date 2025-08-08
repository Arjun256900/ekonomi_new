import 'package:flutter/material.dart';
class Dropdownfield extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final String heading;
  final String? selectedValue;
  final ValueChanged<String> onChanged;

  const Dropdownfield({
    super.key,
    required this.items,
    required this.hintText,
    required this.heading,
    required this.onChanged,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Container(
          height: 54.0,
          width: 380.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.3), width: 0.5),
          ),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                value: selectedValue,
                hint: Text(hintText),
                style: TextStyle(fontSize: 14, color: Colors.black),
                items: items.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                icon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onChanged(newValue);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
