import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/app_translations.dart';
import '../resources/app_colors.dart';

Widget customizedTitleTextFormField(TextEditingController titleController){
  return Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextFormField(
      controller: titleController,
      decoration: InputDecoration(
        hintText: LocalizationService.instance.tr.enterTitle,
        border: InputBorder.none,
      ),
    ),
  );
}

Widget customizedAmountTextFormField(TextEditingController amountController){
  return Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextFormField(
      controller: amountController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        hintText: LocalizationService.instance.tr.enterAmount,
        border: InputBorder.none,
      ),
    ),
  );
}

Widget customizedDescriptionTextFormField(TextEditingController noteController){
  return Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextFormField(
      controller: noteController,
      minLines: 6,
      maxLines: 10,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText:
        LocalizationService.instance.tr.enterDescriptionOrNote,
      ),
    ),
  );
}