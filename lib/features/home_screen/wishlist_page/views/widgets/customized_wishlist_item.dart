import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/resources/app_fonts.dart';
import 'package:wallet/core/resources/app_sizes.dart';

class CustomizedWishlistItem extends StatelessWidget {
  const CustomizedWishlistItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w20),
      width: double.infinity,
      height: AppHeight.h130,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppHeight.h50,
            height: AppWidth.w50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.7,
                  strokeWidth: AppSize.s4,
                  color: AppColors.violetBlue,
                ),
                Text(
                  '70%',
                  style: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppWidth.w20,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Product Name",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: FontSize.s20,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                SizedBox(height: AppHeight.h8,),
                Text(
                  "Saved: \$100",
                  style: TextStyle(
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s14,
                  ),
                ),
                Text("\$100",
                    style: TextStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.regular,
                      color: AppColors.black
                    ),
                    textAlign: TextAlign.end),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
