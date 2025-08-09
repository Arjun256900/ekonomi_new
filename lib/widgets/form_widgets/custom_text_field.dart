import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String heading;
  final String hintText;
  final String initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.heading,
    required this.hintText,
    this.initialValue = '',
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  late bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      // dispose the old internal controller if owned it
      if (_ownsController) {
        _controller.dispose();
      }

      _ownsController = widget.controller == null;
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
    }

    // If initialValue changed and we own the controller and the field is empty,
    // update the text once (prevents clobbering user typing).
    if (_ownsController &&
        widget.initialValue != oldWidget.initialValue &&
        (_controller.text.isEmpty)) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
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
          child: TextFormField(
            controller: _controller,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                fontSize: 14,
              ),
              filled: true,
              fillColor: Colors.white,
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
            ),
          ),
        ),
      ],
    );
  }
}
