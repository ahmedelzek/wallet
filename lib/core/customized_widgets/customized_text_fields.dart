import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/resources/app_fonts.dart';
import 'package:wallet/core/resources/app_sizes.dart';

class CustomizedTextField extends StatelessWidget {
  final String? hintText;
  final String? prefixIcon;
  final bool isNum;
  final bool isNote;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;

  const CustomizedTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.onTap,
    this.isNum = false,
    this.isNote = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        fontSize: FontSize.s12,
        color: AppColors.black
      ),
      validator: validator,
      onTap: onTap,
      minLines: isNote ? 3 : 1,
      maxLines: isNote ? 5 : 1,
      keyboardType: !isNum ? TextInputType.multiline : TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: FontSize.s12
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p18),
      ),
    );
  }
}
