import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_fonts.dart';
import 'package:wallet/core/resources/app_sizes.dart';
import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../resources/app_colors.dart';
import '../resources/transaction_types.dart';
import 'description_show_dialog.dart';

class CustomizedTransactionCard extends StatelessWidget {
  final TransactionEntity transaction;

  const CustomizedTransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    final typeEnum = TransactionTypeExtension.fromKey(transaction.type);

    final localizedType = typeEnum.getLocalizedName(context);
    final color = typeEnum.color;

    return GestureDetector(
      onLongPress: (){
        showDescriptionDialog(
          context,
          transaction.note,
        );
      },
      child: Container(
        padding:  EdgeInsets.all(AppPadding.p12),
        height: AppHeight.h80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.lightGrey2,
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        child: Row(
          children: [
            Container(
              padding:  EdgeInsets.all(AppPadding.p12),
              height: double.infinity,
              width: AppWidth.w4,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppSize.s10),
              ),
            ),
            SizedBox(width: AppWidth.w20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    transaction.title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s14
                    ),
                  ),
                  Text(
                    "${transaction.amount.toString()} ${tr.balanceCurrency}",
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12
                    ),
                  ),
                  Text(
                    localizedType,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
