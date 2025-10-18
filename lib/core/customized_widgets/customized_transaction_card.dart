import 'package:flutter/material.dart';
import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../resources/app_colors.dart';

class CustomizedTransactionCard extends StatefulWidget {
  final TransactionEntity transaction;

  const CustomizedTransactionCard({super.key, required this.transaction});

  @override
  State<CustomizedTransactionCard> createState() =>
      _CustomizedTransactionCardState();
}

class _CustomizedTransactionCardState extends State<CustomizedTransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightGrey2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            width: 4,
            decoration: BoxDecoration(
              color: _setColor(widget.transaction.type),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.transaction.title,
                  style: TextStyle(
                    color: _setColor(widget.transaction.type),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.transaction.amount.toString(),
                  style: TextStyle(
                    color: _setColor(widget.transaction.type),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.transaction.type,
                  style: TextStyle(
                    color: _setColor(widget.transaction.type),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color _setColor(String type) {
  if (type == LocalizationService.instance.tr.income) {
    return AppColors.green;
  } else if (type == LocalizationService.instance.tr.outgoing) {
    return AppColors.red;
  } else if (type == LocalizationService.instance.tr.savings) {
    return AppColors.blue;
  } else if (type == LocalizationService.instance.tr.debtPaid ||
      type == LocalizationService.instance.tr.debtPending) {
    return AppColors.orange;
  }
  return AppColors.grey;
}
