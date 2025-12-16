import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAlllocation_Events.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_bloc.dart';
import 'package:ekonomi_new/models/IncomeAllocation.dart';
import 'package:ekonomi_new/widgets/form_widgets/custom_text_field.dart';
import 'package:ekonomi_new/widgets/form_widgets/dropDownField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../general/Onboard_Btn.dart';

class AddAllocationPopup extends StatefulWidget {
  final IncomeAllocation? existing;

  const AddAllocationPopup({super.key, this.existing});

  @override
  State<AddAllocationPopup> createState() => _AddAllocationPopupState();
}

class _AddAllocationPopupState extends State<AddAllocationPopup> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;

  String? period;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.existing?.title ?? '');
    _amountController = TextEditingController(
      text: widget.existing?.amount.toString() ?? '',
    );

    period = widget.existing?.subtitle ?? 'Monthly';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Text(
              isEdit ? "Edit Allocation" : "Add Allocation",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            /// ACCOUNT NAME
            CustomTextField(
              heading: "Account Name",
              hintText: "e.g Rent",
              controller: _nameController,
              keyboardType: TextInputType.text,
              onChanged: (_) {},
            ),

            const SizedBox(height: 16),

            /// AMOUNT
            CustomTextField(
              heading: "Amount",
              hintText: "Enter amount",
              controller: _amountController,
              keyboardType: TextInputType.number,
              onChanged: (_) {},
            ),

            const SizedBox(height: 16),

            /// PERIOD
            Dropdownfield(
              heading: "Period",
              items: const ['Monthly', 'Weekly', 'Bi-weekly'],
              selectedValue:"Weekly",
              hintText: "Monthly",
              onChanged: (v) => setState(() => period = v),
            ),

            const SizedBox(height: 24),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: OnboardBtn(
                caption: isEdit ? "Update Allocation" : "Save Allocation",
                bgColor: Colors.teal,
                func: _onSave,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSave() {
    final name = _nameController.text.trim();
    final amountText = _amountController.text.trim();

    if (name.isEmpty || amountText.isEmpty) return;

    final amount = double.tryParse(amountText);
    if (amount == null) return;

    final bloc = context.read<IncomeAllocationBloc>();

    if (widget.existing == null) {
      bloc.add(
        AddAllocation(
          IncomeAllocation(
            id: const Uuid().v4(),
            title: name,
            subtitle: period ?? 'Monthly',
            amount: amount,
            icon: Icons.account_balance_wallet,
          ),
        ),
      );
    } else {
      bloc.add(
        UpdateAllocation(
          widget.existing!.copyWith(
            title: name,
            subtitle: period,
            amount: amount,
          ),
        ),
      );
    }

    Navigator.pop(context);
  }
}
