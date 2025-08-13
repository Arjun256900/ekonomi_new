import 'package:ekonomi_new/bloc/AddNewEvent/add_event_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewEvent/add_event_state.dart';
import 'package:ekonomi_new/bloc/AddNewEvent/add_event_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:ekonomi_new/widgets/form_widgets/custom_text_field.dart';
import 'package:ekonomi_new/widgets/form_widgets/dateField.dart';
import 'package:ekonomi_new/widgets/form_widgets/dropDownField.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  static const Color primaryColor = Color.fromRGBO(6, 139, 147, 1);

  final options = const ['Yes', 'No'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => AddEventBloc(),
      child: Stack(
        children: [
          const Positioned.fill(child: Background()),
          Positioned.fill(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: const BackButtonLeading(),
                backgroundColor: Colors.transparent,
                title: const Text(
                  "Add Event",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                  top: screenHeight * 0.025,
                ),
                child: BlocBuilder<AddEventBloc, AddEventState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            heading: 'Event title',
                            hintText: "Enter Event",
                            onChanged: (value) => context
                                .read<AddEventBloc>()
                                .add(TitleChanged(value)),
                          ),
                          const SizedBox(height: 15),
                          DateField(
                            heading: "Date",
                            hintText: 'Pick a date',
                            onDateSelected: (date) => context
                                .read<AddEventBloc>()
                                .add(DateChanged(date)),
                          ),
                          const SizedBox(height: 15),
                          CustomTextField(
                            heading: 'Budget',
                            hintText: "Enter the budget",
                            onChanged: (value) => context
                                .read<AddEventBloc>()
                                .add(BudgetChanged(value)),
                          ),
                          const SizedBox(height: 15),
                          Dropdownfield(
                            items: [
                              'Save weakly',
                              'Save monthly',
                              'Save quarterly',
                              'Save half yearly',
                              'Save annual',
                            ],
                            hintText: "Save Weakly",
                            heading: "Saving Strategy",
                            onChanged: (value) {
                              context
                                  .read<AddEventBloc>()
                                  .add(SavingStrategyChanged(value));
                            },
                            selectedValue: state.strategy.isEmpty
                                ? "Save weakly"
                                : state.strategy,
                          ),
                          const SizedBox(height: 40),
                          const Text('Link to goal'),
                          Row(
                            children: options.map((option) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    value: option,
                                    groupValue: state.linkToGoal,
                                    activeColor: primaryColor,
                                    onChanged: (value) {
                                      context
                                          .read<AddEventBloc>()
                                          .add(LinkToGoalChanged(value));
                                    },
                                  ),
                                  Text(option),
                                  const SizedBox(width: 20),
                                ],
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Add in Reminder"),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => context
                                    .read<AddEventBloc>()
                                    .add(ReminderToggled()),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  padding:
                                      const EdgeInsets.all(4), // space inside box
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: state.isReminderSelected
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state.isSubmitting
                                  ? null
                                  : () {
                                      context
                                          .read<AddEventBloc>()
                                          .add(SaveEventPressed());
                                    },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: const BorderSide(
                                    width: 0.5,
                                    color: Color.fromRGBO(0, 0, 0, 0.45),
                                  ),
                                ),
                                backgroundColor:
                                    Theme.of(context).primaryColor,
                              ),
                              child: state.isSubmitting
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      "Save Event",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
