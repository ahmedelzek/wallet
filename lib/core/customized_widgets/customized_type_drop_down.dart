import 'package:flutter/material.dart';
import '../../l10n/app_translations.dart';
import '../resources/app_colors.dart';
import '../resources/transaction_types.dart';

Widget customizedTypeDropDown(TransactionType? selectedType, Function(TransactionType?) onChanged) {
  return Container(
    height: 50,
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
    ),
    child: DropdownButton<TransactionType>(
      key: ValueKey(selectedType),
      isExpanded: true,
      hint: Text(LocalizationService.instance.tr.selectTransactionType),
      value: selectedType,
      items: TransactionType.values.map((type) {
        return DropdownMenuItem<TransactionType>(
          value: type,
          child: Text(
            type.getLocalizedName(),
            style: TextStyle(
              color: type.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}