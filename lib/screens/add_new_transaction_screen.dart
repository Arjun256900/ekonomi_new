import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_bloc.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_event.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_state.dart';
import 'package:ekonomi_new/widgets/form_widgets/custom_text_field.dart';
import 'package:ekonomi_new/widgets/form_widgets/dateField.dart';
import 'package:ekonomi_new/widgets/form_widgets/dropDownField.dart';
import 'package:ekonomi_new/widgets/form_widgets/file_picker.dart';

class AddNewTransactionScreen extends StatelessWidget {
  const AddNewTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionBloc(),
      child: const AddNewTransactionScreenBody(),
    );
  }
}

class AddNewTransactionScreenBody extends StatefulWidget {
  const AddNewTransactionScreenBody({super.key});

  @override
  State<AddNewTransactionScreenBody> createState() =>
      _AddNewTransactionScreenBodyState();
}

class _AddNewTransactionScreenBodyState
    extends State<AddNewTransactionScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        bool isDebit = state.debitOrCredit == 'Debit';

        return Stack(
          children: [
            Positioned.fill(child: Background()),
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: backButtonLeading(),
                  backgroundColor: const Color.fromARGB(0, 240, 240, 240),
                  title: const Text(
                    "Add Transaction",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Transaction type"),
                          const SizedBox(height: 10),
                          DebitCreditToggle(isDebit: isDebit),

                          const SizedBox(height: 15),
                          Dropdownfield(
                            items: ["Cash", "Online"],
                            hintText: 'Cash',
                            selectedValue: state.sourceSelection.isEmpty
                                ? null
                                : state.sourceSelection,
                            heading: "Source selection",

                            onChanged: (value) {
                              context.read<TransactionBloc>().add(
                                SourceSelectionChanged(value),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            heading: "Amount",
                            hintText: "Enter Amount",
                            initialValue: state.amount,
                            onChanged: (value) {
                              context.read<TransactionBloc>().add(
                                AmountChanged(value),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          DateField(
                            heading: "Date",
                            hintText: "Select Date of Transaction",
                            onDateSelected: (value) {
                              context.read<TransactionBloc>().add(
                                DateChanged(value),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Dropdownfield(
                            items: ["Food", "Others"],
                            hintText: "Eg. Food",
                            heading: "Category",
                            selectedValue: state.category.isEmpty
                                ? null
                                : state.category,
                            onChanged: (value) {
                              context.read<TransactionBloc>().add(
                                CategoryChanged(value),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Upload bill copy",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: " (optional)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 7),
                          FilePickerWidget(
                            subtext:
                                "Select the suitable document for upload here",
                            filepath: state.filepath,
                            onFilePicked: (path) {
                              context.read<TransactionBloc>().add(
                                FilepathChanged(path),
                              );
                            },
                          ),
                          const SizedBox(height: 35),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                // Undo Button
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      context.read<TransactionBloc>().add(
                                        UndoTransaction(),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color.fromARGB(
                                        255,
                                        255,
                                        255,
                                        255,
                                      ),
                                      foregroundColor: Colors.black87,
                                      side: BorderSide(
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
                                const SizedBox(width: 16),
                                // Save Button
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<TransactionBloc>().add(
                                        SubmitTransaction(),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).primaryColor,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Text('Save'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DebitCreditToggle extends StatelessWidget {
  final bool isDebit;

  const DebitCreditToggle({super.key, required this.isDebit});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final lightPrimary = Color.alphaBlend(
      Colors.white.withOpacity(0.5),
      primaryColor,
    );

    return Container(
      height: 35,
      width: 170,
      decoration: BoxDecoration(
        color: lightPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Animated white background
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: isDebit ? 0 : 85,
            child: Container(
              height: 35,
              width: 85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // Foreground Row with buttons
          Row(
            children: [
              // Debit
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isDebit) {
                      context.read<TransactionBloc>().add(
                        DebitOrCreditChanged('Debit'),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          color: isDebit ? Colors.black : Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Debit",
                          style: TextStyle(
                            color: isDebit ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Credit
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isDebit) {
                      context.read<TransactionBloc>().add(
                        DebitOrCreditChanged('Credit'),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: !isDebit ? Colors.black : Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Credit",
                          style: TextStyle(
                            color: !isDebit ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
