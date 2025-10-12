import 'package:flutter/material.dart';

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
              labelColor: AppColors.green,
              indicatorColor: AppColors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
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
            Center(child: Text(LocalizationService.instance.tr.tabAll)),
            Center(child: Text(LocalizationService.instance.tr.tabPending)),
            Center(child: Text(LocalizationService.instance.tr.tabPaid)),
          ],
        ),
      ),
    );
  }
}
