import 'package:flutter/material.dart';
import 'package:wallet/features/home/statistics_page/statistics_page.dart';
import 'package:wallet/features/home/transactions_page/transactions_page.dart';
import '../../core/resources/app_colors.dart';
import 'debts_page/debts_page.dart';
import 'home_page/home_page.dart';

List<BottomNavigationBarItem> generateBottomNavItems(
    Map<IconData, String> iconMap) {
  return iconMap.entries
      .map((entry) => BottomNavigationBarItem(
    icon: Icon(entry.key, color: Colors.grey),
    activeIcon: Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        decoration: BoxDecoration(
            color: AppColors.transparentGreenColor,
            borderRadius: BorderRadius.circular(10)),
        child: Icon(entry.key, color: AppColors.greenColor)),
    backgroundColor: Colors.white,
    label: entry.value,
  )
  ).toList();
}

List<Widget> taps = [
  const HomePage(),
  const TransactionsPage(),
  const DebtsPage(),
  const StatisticsPage(),
];
