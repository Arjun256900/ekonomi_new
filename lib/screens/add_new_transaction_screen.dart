import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAlllocation_Events.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_State.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_bloc.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/general/error_snackbar.dart';
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
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final isDebit = state.debitOrCredit == 'Debit';
        final allocationState = context.watch<IncomeAllocationBloc>().state;

        return Stack(
          children: [
            Positioned.fill(child: Background()),
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: BackButtonLeading(),
                    backgroundColor: Colors.transparent,
                    title: const Text(
                      "Add Transaction",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Transaction type"),
                          const SizedBox(height: 10),
                          DebitCreditToggle(isDebit: isDebit),

                          const SizedBox(height: 15),

                          /// 🔹 ACCOUNT SELECTION DROPDOWN (NEW)
                          BlocBuilder<
                            IncomeAllocationBloc,
                            IncomeAllocationState
                          >(
                            builder: (context, allocationState) {
                              // Use first allocation's ID if selectedAllocationId is empty or invalid
                              final validSelectedId =
                                  allocationState
                                          .selectedAllocationId
                                          .isNotEmpty &&
                                      allocationState.allocations.any(
                                        (a) =>
                                            a.id ==
                                            allocationState
                                                .selectedAllocationId,
                                      )
                                  ? allocationState.selectedAllocationId
                                  : (allocationState.allocations.isNotEmpty
                                        ? allocationState.allocations.first.id
                                        : null);

                              return DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  labelText: 'Select Allocation',
                                ),
                                value: validSelectedId,
                                items: allocationState.allocations
                                    .map(
                                      (a) => DropdownMenuItem(
                                        value: a.id,
                                        child: Text(a.title),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    context.read<IncomeAllocationBloc>().add(
                                      SelectAllocation(value),
                                    );
                                    context.read<TransactionBloc>().add(
                                      AllocationChanged(value),
                                    );
                                  }
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 10),

                          Dropdownfield(
                            items: const ["Cash", "Online"],
                            hintText: 'Cash',
                            heading: "Source selection",
                            selectedValue: state.sourceSelection.isEmpty
                                ? null
                                : state.sourceSelection,
                            onChanged: (value) {
                              context.read<TransactionBloc>().add(
                                SourceSelectionChanged(value),
                              );
                            },
                          ),

                          const SizedBox(height: 10),

                          CustomTextField(
                            controller: amountController,
                            heading: "Amount",
                            hintText: "Enter Amount",
                            keyboardType: TextInputType.number,
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
                            items: const ["Food", "Bills", "Travel", "Others"],
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

                          const Text(
                            "Upload bill copy (optional)",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 7),

                          FilePickerWidget(
                            filepath: state.filepath,
                            subtext:
                                "Select the suitable document for upload here",
                            onFilePicked: (path) {
                              context.read<TransactionBloc>().add(
                                FilepathChanged(path),
                              );
                            },
                          ),

                          const SizedBox(height: 35),

                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    context.read<TransactionBloc>().add(
                                      UndoTransaction(),
                                    );
                                    amountController.clear();
                                  },
                                  child: const Text('Undo'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: state.isValid
                                      ? () {
                                          context.read<TransactionBloc>().add(
                                            SubmitTransaction(context),
                                          );
                                          Navigator.pop(context);
                                        }
                                      : () {
                                          showErrorSnackBar(
                                            context,
                                            "Please fill all fields",
                                          );
                                        },
                                  child: const Text('Save'),
                                ),
                              ),
                            ],
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
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
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isDebit) {
                      context.read<TransactionBloc>().add(
                        DebitOrCreditChanged('Debit'),
                      );
                    }
                  },
                  child: const Center(child: Text("Debit")),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isDebit) {
                      context.read<TransactionBloc>().add(
                        DebitOrCreditChanged('Credit'),
                      );
                    }
                  },
                  child: const Center(child: Text("Credit")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
