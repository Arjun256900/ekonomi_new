import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/AddNewDebt/add_new_debt_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewDebt/add_new_debt_event.dart';
import 'package:ekonomi_new/bloc/AddNewDebt/add_new_debt_state.dart';
import 'package:ekonomi_new/widgets/form_widgets/custom_text_field.dart';
import 'package:ekonomi_new/widgets/form_widgets/dateField.dart';
import 'package:ekonomi_new/widgets/form_widgets/dropDownField.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/general/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewDebt extends StatefulWidget {
  const AddNewDebt({super.key});

  @override
  State<AddNewDebt> createState() => _AddNewDebtState();
}

class _AddNewDebtState extends State<AddNewDebt> {
  int selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: Background()),
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: BackButtonLeading(),
              title: Text(
                "Add a New Debt",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = 0;
                            });
                          },
                          child: Container(
                            width: 114,
                            height: 34,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedOption == 0
                                  ? Colors.teal
                                  : Colors.white,
                              border: Border.all(
                                color: selectedOption == 0
                                    ? Colors.teal
                                    : Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Text(
                              "New Debt",
                              style: TextStyle(
                                color: selectedOption == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = 1;
                            });
                          },
                          child: Container(
                            width: 114,
                            height: 34,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedOption == 1
                                  ? Colors.teal
                                  : Colors.white,
                              border: Border.all(
                                color: selectedOption == 1
                                    ? Colors.teal
                                    : Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Text(
                              "Repayment",
                              style: TextStyle(
                                color: selectedOption == 1
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    selectedOption == 0
                        ? BlocProvider(
                            create: (_) => AddNewDebtBloc(),
                            child: const NewDebt(),
                          )
                        : const Repayment(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewDebt extends StatefulWidget {
  const NewDebt({super.key});

  @override
  State<NewDebt> createState() => _NewDebtState();
}

class _NewDebtState extends State<NewDebt> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewDebtBloc, AddNewDebtState>(
      builder: (context, state) {
        final bloc = context.read<AddNewDebtBloc>(); // ✅ Correct bloc

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Dropdownfield(
                items: ["Personal Loan", "Home Loan", "Car Loan"],
                hintText: "Personal Loan",
                heading: "Loan Type",
                onChanged: (value) {
                  bloc.add(LoanTypeChanged(value));
                },
                selectedValue: state.loanType,
              ),
              const SizedBox(height: 10),

              Dropdownfield(
                items: ["Bank 1", "Bank 2", "Bank 3"],
                hintText: "Select Your Bank",
                heading: "Lender Name",
                onChanged: (value) {
                  bloc.add(LenderNameChanged(value));
                },
                selectedValue: state.lenderName,
              ),
              const SizedBox(height: 10),

              CustomTextField(
                heading: "Loan Amount",
                hintText: "₹00,000",
                keyboardType: TextInputType.number,
                controller: amountController,
                onChanged: (value) {
                  final double amount = double.tryParse(value) ?? 0;
                  bloc.add(LoanAmountChanged(amount));
                },
              ),
              const SizedBox(height: 10),

              CustomTextField(
                heading: "Interest Rate (%)",
                hintText: "Percentage",
                keyboardType: TextInputType.number,
                controller: rateController,
                onChanged: (value) {
                  final double rate = double.tryParse(value) ?? 0;
                  bloc.add(InterestRateChanged(rate));
                },
              ),
              const SizedBox(height: 10),

              DateField(
                heading: "Start Date",
                hintText: "dd/mm/yyyy",
                onDateSelected: (date) {
                  bloc.add(StartDateChanged(date));
                },
              ),
              const SizedBox(height: 10),

              DateField(
                heading: "End Date",
                hintText: "dd/mm/yyyy",
                onDateSelected: (date) {
                  bloc.add(EndDateChanged(date));
                },
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bloc.add(FormReset());
                        amountController.clear();
                        rateController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        side: const BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          width: 0.5,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Undo'),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bloc.add(FormSubmitted());
                        if (state.isValid) {
                          final json = state.toJson();
                          debugPrint('Final Loan Data: $json');
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Loan Data"),
                              content: Text(json.toString()),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill all fields correctly"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 0,
                      ),
                      child: state.isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class Repayment extends StatefulWidget {
  const Repayment({super.key});

  @override
  State<Repayment> createState() => _RepaymentState();
}

class _RepaymentState extends State<Repayment> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16.0));
  }
}
