import 'package:flutter/material.dart';
import '../../l10n/app_translations.dart';
import '../resources/app_colors.dart';

enum TransactionType {
  income,
  outgoing,
  savings,
  debts,
}

extension TransactionTypeExtension on TransactionType {
  String get key => toString().split('.').last;

  String getLocalizedName(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    switch (this) {
      case TransactionType.income:
        return tr.income;
      case TransactionType.outgoing:
        return tr.outgoing;
      case TransactionType.savings:
        return tr.savings;
      case TransactionType.debts:
        return tr.debts;
    }
  }

  Color get color {
    switch (this) {
      case TransactionType.income:
        return AppColors.green;
      case TransactionType.outgoing:
        return AppColors.red;
      case TransactionType.savings:
        return AppColors.blue;
      case TransactionType.debts:
        return AppColors.orange;
    }
  }

  static TransactionType fromKey(String key) {
    return TransactionType.values.firstWhere(
          (t) => t.key == key,
      orElse: () => TransactionType.income,
    );
  }
}
