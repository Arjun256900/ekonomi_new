import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/Income_Onboard/IncomeBloc.dart';
import 'package:ekonomi_new/bloc/Income_Onboard/IncomeState.dart';
import 'package:ekonomi_new/models/IncomeAllocation.dart';
import 'package:ekonomi_new/screens/Goal_Selection.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_bloc.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_State.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAlllocation_Events.dart';

import 'package:ekonomi_new/widgets/Income/AllocationTile.dart';
import 'package:ekonomi_new/widgets/popups/AddAllocationPopup.dart';
import 'package:ekonomi_new/widgets/general/Onboard_Btn.dart';

class IncomeAllocationScreen extends StatelessWidget {
  const IncomeAllocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: BackButtonLeading(),
              title: const Text(
                "Income Allocation",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: BlocBuilder<IncomeAllocationBloc, IncomeAllocationState>(
                builder: (context, state) {
                  final progress = state.totalIncome == 0
                      ? 0.0
                      : state.totalAllocated / state.totalIncome;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      /// TOTAL INCOME
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "\$${state.totalIncome.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "Your Monthly Income",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// PROGRESS
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text("Total Allocated"),
                                const Spacer(),
                                Text(
                                  "\$${state.totalAllocated.toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: progress.clamp(0, 1),
                              backgroundColor: Colors.white,
                              color: Colors.teal,
                              minHeight: 8,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "\$${state.remaining.toStringAsFixed(2)} remaining",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// ALLOCATIONS LIST
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            ...state.allocations.map(
                              (allocation) => AllocationTile(
                                allocation: allocation,
                                onEdit: () => _openAllocationPopup(
                                  context,
                                  allocation: allocation,
                                ),
                                onDelete: () => context
                                    .read<IncomeAllocationBloc>()
                                    .add(DeleteAllocation(allocation.id)),
                              ),
                            ),

                            /// ADD CUSTOM
                            GestureDetector(
                              onTap: () => _openAllocationPopup(context),
                              child: Container(
                                margin: const EdgeInsets.only(top: 12),
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add, color: Colors.teal),
                                    SizedBox(width: 8),
                                    Text(
                                      "Add Custom Allocation",
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// SAVE BUTTON
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          child: OnboardBtn(
                            caption: "Save Allocation",
                            bgColor: Colors.teal,
                            func: () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (_) => GoalSelection(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openAllocationPopup(
    BuildContext context, {
    IncomeAllocation? allocation,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1C1F26),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.85,
        child: BlocProvider.value(
          value: context.read<IncomeAllocationBloc>(),
          child: AddAllocationPopup(existing: allocation),
        ),
      ),
    );
  }
}
