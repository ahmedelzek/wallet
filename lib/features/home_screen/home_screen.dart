import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

        bottomNavigationBar: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 8, color: AppColors.transparentGreen),
              ),
              child: BottomNavigationBar(
                selectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                iconSize: 32,
                selectedItemColor: AppColors.green,
                unselectedItemColor: Colors.grey,
                onTap: changeTab,
                type: BottomNavigationBarType.fixed,
                currentIndex: selectedIndex,
                items: generateBottomNavItems({
                  Icons.home: LocalizationService.instance.tr.home,
                  Icons.library_books_sharp: LocalizationService.instance.tr.transactions,
                  Icons.wallet: LocalizationService.instance.tr.debts,
                  Icons.settings: LocalizationService.instance.tr.settings,
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
