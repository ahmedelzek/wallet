import 'package:flutter/material.dart';

import '../../../core/resources/app_colors.dart';

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
              labelColor: AppColors.greenColor,
              indicatorColor: AppColors.greenColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              tabs: [Tab(text: "All"), Tab(text: "Pending"), Tab(text: "Paid")],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("All")),
            Center(child: Text("Pending")),
            Center(child: Text("Paid")),
          ],
        ),
      ),
    );
  }
}
