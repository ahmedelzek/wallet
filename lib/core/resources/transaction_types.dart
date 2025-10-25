import 'package:flutter/material.dart';
import '../../l10n/app_translations.dart';
import '../resources/app_colors.dart';

enum TransactionType {
  income,
  outgoing,
  savings,
  debtPending,
  debtPaid,
}

extension TransactionTypeExtension on TransactionType {
  String get key => toString().split('.').last;

  String getLocalizedName() {
    final tr = LocalizationService.instance.tr;
    switch (this) {
      case TransactionType.income:
        return tr.income;
      case TransactionType.outgoing:
        return tr.outgoing;
      case TransactionType.savings:
        return tr.savings;
      case TransactionType.debtPending:
        return tr.debtPending;
      case TransactionType.debtPaid:
        return tr.debtPaid;
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
      case TransactionType.debtPending:
      case TransactionType.debtPaid:
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
