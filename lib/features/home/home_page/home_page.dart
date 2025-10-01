import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/features/home/home_page/home_page_widgets.dart';

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
              color: AppColors.darkGreenColor,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 300,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Balance",
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
                      "Income",
                      "4000.0",
                      Icons.arrow_downward,
                      AppColors.greenColor,
                    ),
                    SizedBox(width: 20),
                    balanceCard(
                      "Outgoing",
                      "2000.0",
                      Icons.arrow_upward,
                      AppColors.redColor,
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
              color: AppColors.transparentGreenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Quick Transactions",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonContainer(
                AppColors.transparentGreenColor,
                AppColors.darkGreenColor,
                Icons.add,
              ),
              SizedBox(width: 20),
              buttonContainer(
                AppColors.transparentRedColor,
                AppColors.redColor,
                Icons.remove,
              ),
              SizedBox(width: 20),
              buttonContainer(
                AppColors.transparentOrangeColor,
                AppColors.orangeColor,
                Icons.account_balance,
              ),
              SizedBox(width: 20),
              buttonContainer(
                AppColors.transparentBlueColor,
                AppColors.blueColor,
                Icons.account_balance_wallet,
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                "No Transactions Yet",
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
