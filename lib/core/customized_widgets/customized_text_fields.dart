import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      validator: validator,
      onTap: onTap,
      minLines: isNote ? 3 : 1,
      maxLines: isNote ? 5 : 1,
      keyboardType: !isNum ? TextInputType.multiline : TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      ),
    );
  }
}
