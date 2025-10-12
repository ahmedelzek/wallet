import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/core/customized_widgets/customized_transaction_card.dart';
import 'package:wallet/core/resources/app_colors.dart';

import '../../../l10n/app_translations.dart';
import '../../add_transaction_screen/add_transaction_screen.dart';
import 'cubit/transaction_cubit.dart';
import 'cubit/transaction_state.dart';
import 'home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                 Navigator.pushNamed(
                  context,
                  AddTransactionScreen.routeName,
                );
                context.read<TransactionCubit>().loadTransactions();
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
              child: BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    context.read<TransactionCubit>().loadTransactions();
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TransactionLoaded) {
                    if (state.transactions.isEmpty) {
                      return const Center(child: Text("No transactions yet"));
                    }
                    return ListView.builder(
                      itemCount: state.transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = state.transactions[index];
                        return CustomizedTransactionCard(
                          transaction: transaction,
                        );
                      },
                    );
                  } else if (state is TransactionError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      );
  }
}
