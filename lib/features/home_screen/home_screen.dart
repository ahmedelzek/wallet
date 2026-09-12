import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_sizes.dart';

import '../../core/resources/app_colors.dart';
import '../../l10n/app_translations.dart';
import 'home_widgets.dart';

class HomeScreen extends StatefulWidget {
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
    final tr = LocalizationService.instance.tr(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: taps[selectedIndex],
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: AppMargin.m14, horizontal: AppMargin.m14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s24),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: AppSize.s20,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              backgroundColor: AppColors.green,
              selectedItemColor: AppColors.darkGreen,
              unselectedItemColor: AppColors.white,
              onTap: changeTab,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              items: generateBottomNavItems({
                Icons.home: tr.home,
                Icons.library_books_sharp: tr.transactions,
                Icons.stars_rounded: tr.wishlist,
                Icons.settings: tr.settings,
              }),
            ),
          ),
        ),
      ),
    );
  }
}
