import 'package:flutter/material.dart';

class OnboardBtn extends StatelessWidget {
  final String caption;
  final VoidCallback func;
  final Color bgColor;
  const OnboardBtn({
    super.key,
    required this.func,
    required this.caption,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        fixedSize: MaterialStateProperty.all(const Size(350, 65)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      onPressed: func,
      child: Text(
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        caption,
      ),
    );
  }
}
