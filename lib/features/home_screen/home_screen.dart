import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/core/app_router/app_router_keys.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: taps[selectedIndex],

        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BottomNavigationBar(
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              elevation: 0,
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              iconSize: 24,
              backgroundColor: AppColors.green,
              selectedItemColor: AppColors.darkGreen,
              unselectedItemColor: AppColors.white,
              onTap: changeTab,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              items: generateBottomNavItems({
                Icons.home: LocalizationService.instance.tr.home,
                Icons.library_books_sharp:
                    LocalizationService.instance.tr.transactions,
                Icons.wallet: LocalizationService.instance.tr.debts,
                Icons.settings: LocalizationService.instance.tr.settings,
              }),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(AppRouterKeys.addTransaction);
          },
          backgroundColor: AppColors.green,
          child: Icon(Icons.add, color: AppColors.white,size: 32,),
        ),
      ),
    );
  }
}
