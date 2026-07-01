import 'package:flutter/material.dart';
import 'package:wallet/features/home_screen/settings_page/settings_page.dart';
import 'package:wallet/features/home_screen/transactions_page/transactions_page.dart';
import 'package:wallet/features/home_screen/wishlist_page/wishlist_page.dart';
import '../../core/resources/app_colors.dart';
import 'home_page/home_page.dart';

List<BottomNavigationBarItem> generateBottomNavItems(
    Map<IconData, String> iconMap) {
  return iconMap.entries
      .map((entry) => BottomNavigationBarItem(
    icon: Icon(entry.key, color: AppColors.white),
    activeIcon: Icon(entry.key, color: AppColors.darkGreen),
    backgroundColor: Colors.white,
    label: entry.value,
  )
  ).toList();
}

List<Widget> taps = [
  const HomePage(),
  const TransactionsPage(),
  const WishlistPage(),
  const SettingsPage(),
];
