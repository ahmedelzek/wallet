import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_fonts.dart';
import 'package:wallet/core/resources/app_sizes.dart';
import 'package:wallet/features/home_screen/settings_page/views/settings_page.dart';
import 'package:wallet/features/home_screen/transactions_page/views/transactions_page.dart';
import 'package:wallet/features/home_screen/wishlist_page/views/wishlist_page.dart';
import '../../core/resources/app_colors.dart';
import 'home_page/views/home_page.dart';

List<BottomNavigationBarItem> generateBottomNavItems(
    Map<IconData, String> iconMap) {
  return iconMap.entries
      .map((entry) => BottomNavigationBarItem(
    icon: Icon(entry.key, color: AppColors.white),
    activeIcon: Center(
      child: Container(
        height: AppHeight.h30,
        width:double.infinity,
        padding: EdgeInsets.symmetric(horizontal: AppWidth.w4),
        margin: EdgeInsets.symmetric(horizontal: AppWidth.w8),
        decoration: BoxDecoration(
          color: AppColors.mintWhite,
          borderRadius: BorderRadius.circular(AppSize.s10)
        ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                entry.key,
                color: AppColors.darkGreen,
                size: AppSize.s18,
              ),
      
              SizedBox(width: AppWidth.w4),
      
              Flexible(
                child: Text(
                  entry.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    color: AppColors.darkGreen,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
            ],
          ),),
    ),
    backgroundColor: AppColors.white,
    label: ''
  )
  ).toList();
}

List<Widget> taps = [
  const HomePage(),
  const TransactionsPage(),
  const WishlistPage(),
  const SettingsPage(),
];
