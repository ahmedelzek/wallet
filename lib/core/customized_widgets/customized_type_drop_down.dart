import 'package:flutter/material.dart';

import '../../l10n/app_translations.dart';
import '../resources/app_colors.dart';
import '../resources/color_list.dart';

Widget customizedTypeDropDown(String? selectedType, Function(String?) setState){
  return Container(
    height: 50,
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
    ),
    child: DropdownButton<String>(
      isExpanded: true,
      hint: Text(LocalizationService.instance.tr.selectTransactionType),
      value: selectedType,
      items: typeColors.keys.map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(
            type,
            style: TextStyle(
              color: typeColors[type],
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
       setState(newValue);
      },
    ),
  );
}