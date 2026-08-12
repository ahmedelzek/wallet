import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/resources/app_sizes.dart';

import '../resources/app_fonts.dart';

class CustomizedButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Color? color;

  const CustomizedButton({
    super.key,
    required this.text,
    this.onTap,
    this.color = AppColors.green,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppHeight.h55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppPadding.p16),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.white,
              fontSize: FontSize.s16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
