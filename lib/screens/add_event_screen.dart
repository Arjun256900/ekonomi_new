import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:ekonomi_new/widgets/form_widgets/custom_text_field.dart';
import 'package:ekonomi_new/widgets/form_widgets/dateField.dart';
import 'package:ekonomi_new/widgets/form_widgets/dropDownField.dart';

import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  static const Color primaryColor = Color.fromRGBO(6, 139, 147, 1);
  bool isReminderSelected = false;

  final options = ['Yes', 'No'];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: BackButtonLeading(),
                backgroundColor: Colors.transparent,
                title: Text(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      heading: 'Event title',
                      hintText: "Enter Event",
                    ),
                    const SizedBox(height: 15),
                    DateField(heading: "Date", hintText: 'Pick a date'),
                    const SizedBox(height: 15),
                    CustomTextField(
                      heading: 'Budget',
                      hintText: "Enter the budget",
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
                        print(value);
                      },
                      selectedValue: "Save weakly",
                    ),
                    const SizedBox(height: 40),
                    Text('Link to goal'),
                    Row(
                      children: options.map((option) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value: option,
                              groupValue: selectedValue,
                              activeColor: primaryColor,
                              onChanged: (value) {
                                setState(() => selectedValue = value);
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
                        Text("Add in Reminder"),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isReminderSelected = !isReminderSelected;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            padding: EdgeInsets.all(4), // space inside the box
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: isReminderSelected
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity, // for full width
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: const BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(0, 0, 0, 0.45),
                            ),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: const Text(
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
