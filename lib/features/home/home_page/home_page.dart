import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/features/home/home_page/home_page_widgets.dart';

import '../../../l10n/app_translations.dart';
import '../add_transaction_screen/add_transaction_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        spacing: 20,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.darkGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 300,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalizationService.instance.tr.currentBalance,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "00.0  EGP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    balanceCard(
                      LocalizationService.instance.tr.income,
                      "4000.0",
                      Icons.arrow_downward,
                      AppColors.green,
                    ),
                    SizedBox(width: 20),
                    balanceCard(
                      LocalizationService.instance.tr.outgoing,
                      "2000.0",
                      Icons.arrow_upward,
                      AppColors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.transparentGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              LocalizationService.instance.tr.quickTransactions,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AddTransactionScreen.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonContainer(
                  AppColors.transparentGreen,
                  AppColors.darkGreen,
                  Icons.add,
                ),
                SizedBox(width: 20),
                buttonContainer(
                  AppColors.transparentRed,
                  AppColors.red,
                  Icons.remove,
                ),
                SizedBox(width: 20),
                buttonContainer(
                  AppColors.transparentOrange,
                  AppColors.orange,
                  Icons.account_balance,
                ),
                SizedBox(width: 20),
                buttonContainer(
                  AppColors.transparentBlue,
                  AppColors.blue,
                  Icons.account_balance_wallet,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                LocalizationService.instance.tr.noTransactionsYet,
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
