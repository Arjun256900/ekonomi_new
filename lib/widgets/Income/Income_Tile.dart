import 'package:ekonomi_new/bloc/Income_Onboard/IncomeBloc.dart';
import 'package:ekonomi_new/bloc/Income_Onboard/IncomeEvent.dart';
import 'package:ekonomi_new/models/IncomeModel.dart';
import 'package:ekonomi_new/screens/Inocme_Onboard.dart';
import 'package:ekonomi_new/widgets/popups/Income_Onboard_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeTile extends StatelessWidget {
  final IncomeSource income;
  final int index;

  const IncomeTile({required this.income, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.work, color: Colors.teal),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  income.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  income.period,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${income.amount.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              /// MENU
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onSelected: (value) {
                  if (value == 'edit') {
                    _openEdit(context);
                  } else if (value == 'delete') {
                    context.read<IncomeBloc>().add(DeleteIncomeSource(index));
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openEdit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1C1F26),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => IncomeOnboardPopup(
        isEdit: true,
        index: index,
        existingIncome: income,
      ),
    );
  }
}
