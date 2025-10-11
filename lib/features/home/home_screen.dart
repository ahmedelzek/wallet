import 'package:flutter/material.dart';

import '../../core/resources/app_colors.dart';
import '../../l10n/app_translations.dart';
import 'home_widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: taps[selectedIndex],
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(width: 8, color: AppColors.transparentGreen)
          ),
          child: BottomNavigationBar(
              selectedLabelStyle: const TextStyle(
                fontSize: 12, // Fixed font size
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12, // Same as selected
                fontWeight: FontWeight.w500,
              ),
              iconSize: 32,
              selectedItemColor: AppColors.green,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                changeTab(index);
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              items: generateBottomNavItems({
                Icons.home: LocalizationService.instance.tr.home,
                Icons.library_books_sharp: LocalizationService.instance.tr.transactions,
                Icons.wallet: LocalizationService.instance.tr.debts,
                Icons.bar_chart: LocalizationService.instance.tr.statistics,
              })),
        ),
      ),
    );
  }
}
