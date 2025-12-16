import 'package:ekonomi_new/bloc/Income_Onboard/IncomeBloc.dart';
import 'package:ekonomi_new/bloc/Income_Onboard/IncomeEvent.dart';
import 'package:ekonomi_new/models/IncomeModel.dart';
import 'package:ekonomi_new/widgets/form_widgets/custom_text_field.dart';
import 'package:ekonomi_new/widgets/form_widgets/dropDownField.dart';
import 'package:ekonomi_new/widgets/general/Onboard_Btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeOnboardPopup extends StatefulWidget {
  final bool isEdit;
  final int? index;
  final IncomeSource? existingIncome;

  const IncomeOnboardPopup({
    super.key,
    this.isEdit = false,
    this.index,
    this.existingIncome,
  });

  @override
  State<IncomeOnboardPopup> createState() => _IncomeOnboardPopupState();
}
class _IncomeOnboardPopupState extends State<IncomeOnboardPopup> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  String? _period;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.existingIncome?.name ?? '');
    _amountController = TextEditingController(
        text: widget.existingIncome?.amount.toString() ?? '');
    _period = widget.existingIncome?.period;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            heading: "Income Name",
            hintText: "Salary / Freelance",
            controller: _nameController,
            keyboardType: TextInputType.text,
            onChanged: (_) {},
          ),

          const SizedBox(height: 16),

          CustomTextField(
            heading: "Amount",
            hintText: "Enter amount",
            controller: _amountController,
            keyboardType: TextInputType.number,
            onChanged: (_) {},
          ),

          const SizedBox(height: 16),

          Dropdownfield(
            heading: "Period",
            items: const ['Monthly', 'Weekly', 'Bi-weekly'],
            selectedValue: _period,
            hintText: "Monthly",
            onChanged: (v) => setState(() => _period = v),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: OnboardBtn(
              caption: widget.isEdit ? "Update" : "Add",
              bgColor: Colors.teal,
              func: () {
                final income = IncomeSource(
                  name: _nameController.text,
                  amount:
                      double.tryParse(_amountController.text) ?? 0,
                  type: "Primary",
                  period: _period ?? "Monthly",
                );

                if (widget.isEdit) {
                  context.read<IncomeBloc>().add(
                        UpdateIncomeSource(widget.index!, income),
                      );
                } else {
                  context
                      .read<IncomeBloc>()
                      .add(AddIncomeSource(income));
                }

                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
