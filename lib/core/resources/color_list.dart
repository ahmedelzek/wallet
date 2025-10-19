import 'dart:ui';

import '../../l10n/app_translations.dart';
import 'app_colors.dart';

final Map<String, Color> typeColors = {
  LocalizationService.instance.tr.income: AppColors.green,
  LocalizationService.instance.tr.outgoing: AppColors.red,
  LocalizationService.instance.tr.savings: AppColors.blue,
  LocalizationService.instance.tr.debtPending: AppColors.orange,
  LocalizationService.instance.tr.debtPaid: AppColors.orange,
};
