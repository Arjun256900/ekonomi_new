import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekonomi_new/bloc/goal/form_bloc.dart';
import 'package:ekonomi_new/bloc/goal/form_event.dart';
import 'package:ekonomi_new/bloc/goal/form_state.dart';
import 'package:ekonomi_new/widgets/form_widgets/custom_text_field.dart';
import 'package:ekonomi_new/widgets/form_widgets/dateField.dart';
import 'package:ekonomi_new/widgets/form_widgets/dropDownField.dart';

class AddNewGoal extends StatefulWidget {
  const AddNewGoal({super.key});

  @override
  State<AddNewGoal> createState() => _AddNewGoalState();
}

class _AddNewGoalState extends State<AddNewGoal> {
  late final FormBloc _formBloc;
  late final TextEditingController _goalNameController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _formBloc = FormBloc();
    // initialize controllers from bloc's current state (if any)
    _goalNameController = TextEditingController(text: _formBloc.state.goalName);
    _amountController = TextEditingController(text: _formBloc.state.amount);
  }

  @override
  void dispose() {
    _goalNameController.dispose();
    _amountController.dispose();
    _formBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        // Keep GestureDetector to dismiss keyboard on outside tap
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocProvider.value(
            value: _formBloc,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: backButtonLeading(),
                title: Text(
                  "Add New Goal",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.transparent,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<FormBloc, GoalState>(
                      builder: (context, state) {
                        final bloc = context.read<FormBloc>();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // IMPORTANT: pass controller instead of initialValue
                            CustomTextField(
                              heading: "Goal Name",
                              hintText: "Enter your Goal Name",
                              controller: _goalNameController,
                              onChanged: (v) {
                                bloc.add(GoalNameChanged(v));
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              heading: "Target Amount",
                              hintText: "How much do you want to save",
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                bloc.add(TargetAmountChanged(v));
                              },
                            ),
                            const SizedBox(height: 8),
                            DateField(
                              heading: "Target Date",
                              hintText: "Select Target Date",
                              selectedDate: state.date,
                              onDateSelected: (v) => bloc.add(TargetDateChanged(v)),
                            ),
                            const SizedBox(height: 8),
                            Dropdownfield(
                              heading: "Priority Level",
                              items: ['low', 'medium', 'high'],
                              selectedValue: state.priority.isEmpty ? null : state.priority,
                              hintText: 'medium',
                              onChanged: (v) => bloc.add(PrioityLevelChanged(v)),
                            ),
                            const SizedBox(height: 8),
                            Dropdownfield(
                              heading: "Set Source Account",
                              items: ['Account A', 'Account B', 'Account C'],
                              hintText:  'Select Source Account',
                              selectedValue: state.sourceAccount.isEmpty ? null : state.sourceAccount,
                              onChanged: (v) => bloc.add(SourceAccountChanged(v)),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: state.isValid
                                  ? () {
                                      bloc.add(SubmitGoal(context));
                                      Navigator.of(context).pop();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: const BorderSide(
                                    width: 0.5,
                                    color: Color.fromRGBO(0,0,0,0.45),
                                  ),
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              child: const Text(
                                "Set Goal",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
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
            ),
          ),
        ),
      ],
    );
  }
}
