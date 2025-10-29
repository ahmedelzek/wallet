import 'package:flutter/material.dart';
import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../resources/app_colors.dart';
import '../resources/transaction_types.dart';

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
    final typeEnum = TransactionTypeExtension.fromKey(widget.transaction.type);

    final localizedType = typeEnum.getLocalizedName();
    final color = typeEnum.color;

    return Container(
      padding: const EdgeInsets.all(12),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightGrey2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: double.infinity,
            width: 4,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.transaction.title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.transaction.amount.toString()} ${LocalizationService.instance.tr.balanceCurrency}",
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  localizedType,
                  style: TextStyle(
                    color: color,
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
