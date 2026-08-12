import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_fonts.dart';
import 'package:wallet/core/resources/app_sizes.dart';

import '../../l10n/app_translations.dart';
import '../resources/app_colors.dart';
import '../resources/transaction_types.dart';

class CustomizedTypeDropDown extends StatefulWidget {
  final TransactionType? selectedType;
  final Function(TransactionType?) onChanged;

  const CustomizedTypeDropDown({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  State<CustomizedTypeDropDown> createState() => _CustomizedTypeDropDownState();
}

class _CustomizedTypeDropDownState extends State<CustomizedTypeDropDown> {
  late TransactionType? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedType;
  }

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return Container(
      height: AppHeight.h50,
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(AppPadding.p8),
      ),
      child: DropdownButton<TransactionType>(
        isExpanded: true,
        hint: Text(tr.selectTransactionType),
        value: _selected,
        items: TransactionType.values.map((type) {
          return DropdownMenuItem<TransactionType>(
            value: type,
            child: Text(
              type.getLocalizedName(context),
              style: TextStyle(
                fontSize: FontSize.s12,
                color: type.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() => _selected = value);
          widget.onChanged(value);
        },
      ),
    );
  }
}