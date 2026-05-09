import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet/core/resources/app_colors.dart';

class CustomizedButton extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const CustomizedButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
