import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/AddNewSpending/spending_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewSpending/spending_event.dart';
import 'package:ekonomi_new/bloc/AddNewSpending/spending_state.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:ekonomi_new/widgets/form_widgets/custom_text_field.dart';
import 'package:ekonomi_new/widgets/form_widgets/dateField.dart';
import 'package:ekonomi_new/widgets/form_widgets/file_picker.dart';
import 'package:ekonomi_new/widgets/general/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewSpending extends StatefulWidget {
  const AddNewSpending({super.key});

  @override
  State<AddNewSpending> createState() => _AddNewSpendingState();
}

class _AddNewSpendingState extends State<AddNewSpending> {
  late final SpendingBloc _spendingBloc;
  late TextEditingController amountController;
  late TextEditingController notesController;

  bool isValid = false;
  @override
  void initState() {
    super.initState();

    _spendingBloc = SpendingBloc();

    // Initialize controllers with existing state values
    amountController = TextEditingController(text: _spendingBloc.state.amount);

    notesController = TextEditingController(text: _spendingBloc.state.notes);
  }

  @override
  void dispose() {
    // Always dispose controllers
    amountController.dispose();
    notesController.dispose();
    _spendingBloc.close();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _spendingBloc,
      child: BlocBuilder<SpendingBloc, SpendingState>(
        builder: (context, state) {
          return Stack(
            children: [
              const Positioned.fill(child: Background()),
              GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    resizeToAvoidBottomInset: true,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      leading: BackButtonLeading(),
                      title: const Text(
                        "Add Spending",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                heading: "Enter Amount",
                                hintText: "Enter how much did you spend?",
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                onChanged: (val) => context
                                    .read<SpendingBloc>()
                                    .add(AmountChanged(val)),
                              ),
                              const SizedBox(height: 10),
                              DateField(
                                heading: "Date",
                                hintText: "Select date",
                                onDateSelected: (date) => context
                                    .read<SpendingBloc>()
                                    .add(DateChanged(date)),
                              ),
                              const SizedBox(height: 10),
                              CustomTextField2(
                                heading: "Notes",
                                hintText: "Enter notes about your spending.",
                                onChanged: (val) => context
                                    .read<SpendingBloc>()
                                    .add(NotesChanged(val)),
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Upload bill copy",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const TextSpan(
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
                                onFilePicked: (path) => context
                                    .read<SpendingBloc>()
                                    .add(FilepathChanged(path)),
                                filepath: state.filepath,
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          context.read<SpendingBloc>().add(
                                            UndoSpending(),
                                          );
                                          amountController.text = '';
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
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                        child: const Text('Undo'),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: state.isValid
                                            ? () {
                                                context
                                                    .read<SpendingBloc>()
                                                    .add(
                                                      SubmitSpending(context),
                                                    );
                                                Navigator.of(context).pop();
                                              }
                                            : () {
                                                showErrorSnackBar(
                                                  context,
                                                  "Please make sure to fill all the fields",
                                                );
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
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
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
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomTextField2 extends StatefulWidget {
  final String heading;
  final String hintText;
  final String initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final int? maxLines;

  const CustomTextField2({
    super.key,
    required this.heading,
    required this.hintText,
    this.initialValue = '',
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  late TextEditingController _controller;
  late bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant CustomTextField2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      // dispose the old internal controller if owned it
      if (_ownsController) {
        _controller.dispose();
      }

      _ownsController = widget.controller == null;
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
    }

    // If initialValue changed and we own the controller and the field is empty,
    // update the text once (prevents clobbering user typing).
    if (_ownsController &&
        widget.initialValue != oldWidget.initialValue &&
        (_controller.text.isEmpty)) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 119),
          child: TextFormField(
            controller: _controller,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                fontSize: 14,
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
