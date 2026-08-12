import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wallet/core/resources/app_sizes.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import 'customized_slidable_border_radius.dart';

class CustomizedSlidAble extends StatelessWidget {
  final Future<void> Function()? firstFunction;
  final Future<void> Function()? secondFunction;
  final Widget child;

  const CustomizedSlidAble({
    super.key,
    this.firstFunction,
    this.secondFunction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: .4,
        children: [
          CustomSlidableAction(
            onPressed: (_) async{
              await firstFunction?.call();
            },
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            borderRadius: customizedSlidAbleBorderRadius(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete),
                SizedBox(height: AppHeight.h4),
                Text(
                  tr.delete,
                  style: TextStyle(
                    fontSize: FontSize.s12,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          CustomSlidableAction(
            onPressed: (_) async{
              await secondFunction?.call();
            },
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit),
                SizedBox(height: AppHeight.h4),
                Text(
                  tr.edit,
                  style: TextStyle(
                    fontSize: FontSize.s12,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}
