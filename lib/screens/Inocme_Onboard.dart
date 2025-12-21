import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAlllocation_Events.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_bloc.dart';
import 'package:ekonomi_new/bloc/Income_Onboard/IncomeBloc.dart';
import 'package:ekonomi_new/bloc/Income_Onboard/IncomeState.dart';
import 'package:ekonomi_new/screens/Income_Alloc.dart';
import 'package:ekonomi_new/widgets/Income/Income_Tile.dart';
import 'package:ekonomi_new/widgets/general/Onboard_Btn.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/popups/Income_Onboard_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InocmeOnboard extends StatelessWidget {
  const InocmeOnboard({super.key});

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
              title: Text(
                "Monthly Income",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: BlocBuilder<IncomeBloc, IncomeState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      /// Total
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Enter your total monthly income",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "\$ ${state.totalIncome.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// Income Source Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text(
                              "Income Source",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => _openAddSource(context),
                              child: Text(
                                "Add Source",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// List
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: state.incomes.length,
                          itemBuilder: (context, index) {
                            final income = state.incomes[index];
                            return IncomeTile(income: income, index: index);
                          },
                        ),
                      ),

                      /// Save Button
                      /// Save Button
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          child: OnboardBtn(
                            caption: "Save",
                            bgColor: Theme.of(context).primaryColor,
                            func: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const IncomeAllocationScreen(),
                                ),
                              );
                            },
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

  void _openAddSource(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1C1F26),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return BlocProvider.value(
          value: context.read<IncomeBloc>(), // 👈 PASS EXISTING BLOC
          child: const IncomeOnboardPopup(),
        );
      },
    );
  }
}
