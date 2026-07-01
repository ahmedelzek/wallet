import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../resources/app_colors.dart';
import '../resources/transaction_types.dart';

class CustomizedTransactionCard extends StatelessWidget {
  final TransactionEntity transaction;

  const CustomizedTransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    final typeEnum = TransactionTypeExtension.fromKey(transaction.type);

    final localizedType = typeEnum.getLocalizedName(context);
    final color = typeEnum.color;

    return Container(
      padding:  EdgeInsets.all(12.sp),
      height: 80.h,
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
            width: 4.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp
                  ),
                ),
                Text(
                  "${transaction.amount.toString()} ${tr.balanceCurrency}",
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp
                  ),
                ),
                Text(
                  localizedType,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp
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
