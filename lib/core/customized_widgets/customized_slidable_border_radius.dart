import 'package:flutter/material.dart';

BorderRadius customizedSlidAbleBorderRadius(BuildContext context){
  return  BorderRadius.only(
  topLeft: Directionality.of(context) == TextDirection.ltr
  ? const Radius.circular(10)
      : Radius.zero,
  bottomLeft: Directionality.of(context) == TextDirection.ltr
  ? const Radius.circular(10)
      : Radius.zero,
  topRight: Directionality.of(context) == TextDirection.rtl
  ? const Radius.circular(10)
      : Radius.zero,
  bottomRight: Directionality.of(context) == TextDirection.rtl
  ? const Radius.circular(10)
      : Radius.zero,
  );
}