import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_sizes.dart';

BorderRadius customizedSlidAbleBorderRadius(BuildContext context){
  return  BorderRadius.only(
  topLeft: Directionality.of(context) == TextDirection.ltr
  ? Radius.circular(AppSize.s10)
      : Radius.zero,
  bottomLeft: Directionality.of(context) == TextDirection.ltr
  ?  Radius.circular(AppSize.s10)
      : Radius.zero,
  topRight: Directionality.of(context) == TextDirection.rtl
  ?  Radius.circular(AppSize.s10)
      : Radius.zero,
  bottomRight: Directionality.of(context) == TextDirection.rtl
  ?  Radius.circular(AppSize.s10)
      : Radius.zero,
  );
}