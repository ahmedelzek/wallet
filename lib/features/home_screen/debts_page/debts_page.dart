import 'package:flutter/material.dart';
import 'package:wallet/features/home_screen/debts_page/all_debts_view_page.dart';
import 'package:wallet/features/home_screen/debts_page/on_pending_debts_view_page.dart';
import 'package:wallet/features/home_screen/debts_page/paid_debts_view_page.dart';

import '../../../core/resources/app_colors.dart';
import '../../../l10n/app_translations.dart';

class DebtsPage extends StatelessWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 10),
            child: TabBar(
              labelColor: AppColors.orange,
              indicatorColor: AppColors.orange,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: LocalizationService.instance.tr.tabAll),
                Tab(text: LocalizationService.instance.tr.tabPending),
                Tab(text: LocalizationService.instance.tr.tabPaid),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: AllDebtsViewPage()),
            Center(child: OnPendingDebtsViewPage()),
            Center(child: PaidDebtsViewPage()),
          ],
        ),
      ),
    );
  }
}
