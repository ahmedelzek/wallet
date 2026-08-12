import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/core/app_router/app_router_keys.dart';
import 'package:wallet/core/resources/app_fonts.dart';
import 'package:wallet/core/resources/app_sizes.dart';
import 'package:wallet/features/add_transaction_screen/add_transaction_screen.dart';

import '../../core/resources/app_colors.dart';
import '../../features/home_screen/settings_page/cubit/language_cubit.dart';
import '../../l10n/app_translations.dart';
import 'home_widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

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
        backgroundColor: Colors.white,
        body: taps[selectedIndex],
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: AppMargin.m14, horizontal: AppMargin.m14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BottomNavigationBar(
              selectedLabelStyle:  TextStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w500,
              ),
              elevation: 0,
              unselectedLabelStyle:  TextStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w500,
              ),
              iconSize: AppSize.s24,
              backgroundColor: AppColors.green,
              selectedItemColor: AppColors.darkGreen,
              unselectedItemColor: AppColors.white,
              onTap: changeTab,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              items: generateBottomNavItems({
                Icons.home: tr.home,
                Icons.library_books_sharp: tr.transactions,
                Icons.add_shopping_cart: tr.wishlist,
                Icons.settings: tr.settings,
              }),
            ),
          ),
        ),
      ),
    );
  }
}
