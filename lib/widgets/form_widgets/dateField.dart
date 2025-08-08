import 'package:flutter/material.dart';

/// A date picker field that displays a formatted date and calls [onDateSelected] when changed.
class DateField extends StatefulWidget {
  final String heading;
  final String hintText;
  final String selectedDate;          // formatted date string
  final ValueChanged<String>? onDateSelected;

  const DateField({
    super.key,
    required this.heading,
    required this.hintText,
    this.selectedDate = '',
    this.onDateSelected,
  });

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late final TextEditingController _controller;
  DateTime? _pickedDate;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.selectedDate);
    if (widget.selectedDate.isNotEmpty) {
      // Try parse the incoming selectedDate (dd/MM/yyyy)
      final parts = widget.selectedDate.split('/');
      if (parts.length == 3) {
        final d = int.tryParse(parts[0]);
        final m = int.tryParse(parts[1]);
        final y = int.tryParse(parts[2]);
        if (d != null && m != null && y != null) {
          _pickedDate = DateTime(y, m, d);
        }
      }
    }
  }

 @override
void didUpdateWidget(covariant DateField old) {
  super.didUpdateWidget(old);
  if (widget.selectedDate != old.selectedDate) {
    _controller.text = widget.selectedDate;

    // Also update _pickedDate
    if (widget.selectedDate.isNotEmpty) {
      final parts = widget.selectedDate.split('/');
      if (parts.length == 3) {
        final d = int.tryParse(parts[0]);
        final m = int.tryParse(parts[1]);
        final y = int.tryParse(parts[2]);
        if (d != null && m != null && y != null) {
          _pickedDate = DateTime(y, m, d);
        }
      }
    } else {
      _pickedDate = null; // Reset if empty
    }
  }
}


  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _pickedDate ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _pickedDate = picked;
      final formatted = "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
      _controller.text = formatted;
      widget.onDateSelected?.call(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 54),
          child: TextField(
            controller: _controller,
            readOnly: true,
            onTap: () => _selectDate(context),
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              fillColor: Colors.white,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(0, 0, 0, 0.3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  width: 0.5,
                ),
              ),
              suffixIcon: const Padding(
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 18.0,
                  backgroundColor: Color.fromRGBO(3, 150, 157, 0.09),
                  foregroundColor: Colors.white,
                  child: Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: Color.fromRGBO(1, 86, 90, 1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
