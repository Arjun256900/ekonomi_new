import 'package:flutter/material.dart';

class IncomeAllocation {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final IconData icon;
  final bool isDefault;

  /// 🔹 NEW: account support
  final String accountId;

  IncomeAllocation({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    this.isDefault = false,
    this.accountId = 'ALL', // ✅ safe default
  });

  IncomeAllocation copyWith({
    String? title,
    String? subtitle,
    double? amount,
    IconData? icon,
    bool? isDefault,
    String? accountId,
  }) {
    return IncomeAllocation(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      amount: amount ?? this.amount,
      icon: icon ?? this.icon,
      isDefault: isDefault ?? this.isDefault,
      accountId: accountId ?? this.accountId,
    );
  }
}
