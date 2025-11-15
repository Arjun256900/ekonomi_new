import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final VoidCallback onTap;
  final String label;
  const ActionButton({super.key, required this.onTap, required this.label});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 17),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
      onPressed: widget.onTap,
      child: Text(widget.label),
    );
  }
}
