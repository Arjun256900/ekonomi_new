import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/AddNewSavings/Savings_State.dart';
import 'package:ekonomi_new/bloc/AddNewSavings/Savings_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewSavings/Savings_event.dart';
import 'package:ekonomi_new/widgets/form_widgets/custom_text_field.dart';
import 'package:ekonomi_new/widgets/form_widgets/dateField.dart';
import 'package:ekonomi_new/widgets/form_widgets/dropDownField.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewSavings extends StatefulWidget {
  const AddNewSavings({super.key});

  @override
  State<AddNewSavings> createState() => _AddNewSavingsState();
}

class _AddNewSavingsState extends State<AddNewSavings> {
  String? selectedCategory;
  String? selectedSource;

  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SavingsBloc(),
      child: Stack(
        children: [
          /// Background always behind
          const Positioned.fill(child: Background()),

          /// Foreground content
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text("Add Savings"),
              automaticallyImplyLeading: false,
              leading: BackButtonLeading(),
              backgroundColor: Colors.transparent,
            ),
            body: BlocConsumer<SavingsBloc, SavingsState>(
              listener: (context, state) {
                if (state.saved) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Form Saved: ${state.jsonResult}")),
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Amount
                      CustomTextField(
                        heading: "Amount",
                        hintText: "Enter the saving amount",
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        onChanged: (val) =>
                            context.read<SavingsBloc>().add(AmountChanged(val)),
                      ),

                      const SizedBox(height: 16),

                      /// Date
                      DateField(
                        heading: "Date",
                        hintText: "Choose the date",
                        onDateSelected: (pickedDate) {
                          context.read<SavingsBloc>().add(
                            DateChanged(pickedDate),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      /// Dropdown 1 - Savings Category
                      Dropdownfield(
                        items: const ["General", "Personal"],
                        hintText: "General",
                        heading: "Savings Category",
                        selectedValue: state.Category,
                        onChanged: (val) {
                          selectedCategory = val;
                          context.read<SavingsBloc>().add(CategoryChanged(val));
                        },
                      ),

                      const SizedBox(height: 16),

                      /// Dropdown 2 - Payment Source
                      Dropdownfield(
                        items: const ["Bank", "UPI"],
                        hintText: "Bank",
                        heading: "Payments Source",
                        selectedValue: state.Payment,
                        onChanged: (val) {
                          selectedSource = val;
                          context.read<SavingsBloc>().add(PaymentChanged(val));
                        },
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          /// Undo Button
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                context.read<SavingsBloc>().add(UndoForm());
                                amountController.clear();
                                setState(() {
                                  selectedCategory = null;
                                  selectedSource = null;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                side: const BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  width: 0.5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('Undo'),
                            ),
                          ),

                          const SizedBox(width: 12),

                          /// Save Button
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<SavingsBloc>().add(SaveForm());
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
