import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String message) {
  // Hide any existing snackbars to avoid stacking them
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.redAccent,
      behavior:
          SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
    ),
  );  
}
