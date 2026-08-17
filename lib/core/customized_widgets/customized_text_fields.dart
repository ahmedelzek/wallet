import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/resources/app_fonts.dart';
import 'package:wallet/core/resources/app_sizes.dart';

class CustomizedTextField extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final String? label;
  final bool isNum;
  final bool isNote;
  final bool showBorder;
  final Color? fillColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;

  const CustomizedTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.label,
    this.onTap,
    this.fillColor,
    this.showBorder = false,
    this.isNum = false,
    this.isNote = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? "",
          style: TextStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        SizedBox(height: AppHeight.h4),
        TextFormField(
          controller: controller,
          style: TextStyle(fontSize: FontSize.s12, color: AppColors.black),
          validator: validator,
          onTap: onTap,
          minLines: isNote ? 3 : 1,
          maxLines: isNote ? 5 : 1,
          keyboardType: !isNum ? TextInputType.multiline : TextInputType.number,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: FontSize.s12,
              color: AppColors.hintTextColor,
            ),
            filled: true,
            fillColor: fillColor,
            prefixIcon:
                prefixIcon != null
                    ? Icon(
                      prefixIcon,
                      color: AppColors.black,
                      size: AppSize.s18,
                    )
                    : null,
            enabledBorder: showBorder ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
              borderSide: BorderSide(
                color: AppColors.grey,
                width: AppWidth.w1,
              ),
            ): null,
            focusedBorder: showBorder?  OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
              borderSide: BorderSide(
                color: AppColors.grey,
                width: AppWidth.w1,
              ),
            ): null,
          ),
        ),
      ],
    );
  }
}
