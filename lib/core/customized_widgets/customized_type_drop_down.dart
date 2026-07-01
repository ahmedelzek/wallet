import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      height: 50.h,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(10),
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