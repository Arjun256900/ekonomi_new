import 'package:flutter/cupertino.dart';

class DebtItem {
  final String bankName;
  final String subtitle;
  final String amount;
  final String interest;
  final String date;
  final IconData iconData;
  final Color? iconBg;

  const DebtItem({
    required this.bankName,
    required this.subtitle,
    required this.amount,
    required this.interest,
    required this.date,
    required this.iconData,
    this.iconBg,
  });
}
