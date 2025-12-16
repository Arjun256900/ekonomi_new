import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String heading;
  final String hintText;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final Widget? suffixIcon;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.heading,
    required this.hintText,
    required this.keyboardType,
    required this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Heading
        Text(
          heading,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 6),

        /// Text Field
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 54),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.4),
              ),
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
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
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  width: 0.7,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
