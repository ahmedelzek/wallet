import 'package:flutter/material.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../../core/customized_widgets/customized_text_fields.dart';
import '../../core/customized_widgets/customized_type_drop_down.dart';
import '../../core/resources/app_colors.dart';

class UpdateTransactionScreen extends StatefulWidget {
  static const String routeName = "update_transaction";

  const UpdateTransactionScreen({super.key});

  @override
  State<UpdateTransactionScreen> createState() =>
      _UpdateTransactionScreenState();
}

class _UpdateTransactionScreenState extends State<UpdateTransactionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? _selectedType;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'Update Transaction',
          style: TextStyle(color: AppColors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          spacing: 35,
          children: [
            customizedTypeDropDown(_selectedType, (value) {
              setState(() {
                _selectedType = value;
              });
            }),
            customizedTitleTextFormField(_titleController),
            customizedAmountTextFormField(_amountController),
            customizedDescriptionTextFormField(_noteController),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(LocalizationService.instance.tr.saveChanges),
            ),
          ],
        ),
      ),
    );
  }
}
