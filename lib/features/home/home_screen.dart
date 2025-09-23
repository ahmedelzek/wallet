import 'package:flutter/material.dart';

import '../../core/resources/app_colors.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: taps[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
          selectedItemColor: AppColors.greenColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            changeTab(index);
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          backgroundColor: Colors.white,
          items: generateBottomNavItems({
            Icons.home: "Home",
            Icons.wallet: "Debts",
            Icons.library_books_sharp: "Transactions",
            Icons.bar_chart: "statistics",
          })),
    );
  }
}
