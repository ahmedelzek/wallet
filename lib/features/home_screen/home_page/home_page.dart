import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wallet/core/customized_widgets/customized_transaction_card.dart';
import 'package:wallet/core/customized_widgets/description_show_dialog.dart';
import 'package:wallet/core/resources/app_colors.dart';

import '../../../core/customized_widgets/customized_slidable_border_radius.dart';
import '../../../l10n/app_translations.dart';
import '../../add_transaction_screen/add_transaction_screen.dart';
import '../../update_transaction_screen/update_transaction_screen.dart';
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
  void initState() {
    super.initState();
    context.read<TransactionCubit>().loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TransactionLoaded) {
            final income = state.incomeSum.toStringAsFixed(2);
            final outgoing = state.outgoingSum.toStringAsFixed(2);
            final balance = state.netBalance.toStringAsFixed(2);
            return Column(
              spacing: 20,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$balance EGP",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          balanceCard(
                            LocalizationService.instance.tr.income,
                            income,
                            Icons.arrow_downward,
                            AppColors.green,
                          ),
                          const SizedBox(width: 20),
                          balanceCard(
                            LocalizationService.instance.tr.outgoing,
                            outgoing,
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
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.transparentGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    LocalizationService.instance.tr.quickTransactions,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AddTransactionScreen.routeName,
                    ).then((_) {
                      context.read<TransactionCubit>().loadTransactions();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonContainer(
                        AppColors.transparentGreen,
                        AppColors.darkGreen,
                        Icons.add,
                      ),
                      const SizedBox(width: 20),
                      buttonContainer(
                        AppColors.transparentRed,
                        AppColors.red,
                        Icons.remove,
                      ),
                      const SizedBox(width: 20),
                      buttonContainer(
                        AppColors.transparentOrange,
                        AppColors.orange,
                        Icons.account_balance,
                      ),
                      const SizedBox(width: 20),
                      buttonContainer(
                        AppColors.transparentBlue,
                        AppColors.blue,
                        Icons.account_balance_wallet,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:
                      state.transactions.isEmpty
                          ? Center(
                            child: Text(
                              LocalizationService
                                  .instance
                                  .tr
                                  .noTransactionsFound,
                              style: const TextStyle(
                                color: AppColors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                          : ListView.separated(
                            itemCount: state.transactions.length,

                            itemBuilder: (context, index) {
                              final transaction = state.transactions[index];
                              return Slidable(
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: .4,
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        context
                                            .read<TransactionCubit>()
                                            .deleteTransaction(transaction.id);
                                      },
                                      backgroundColor: AppColors.red,
                                      foregroundColor: AppColors.white,
                                      icon: Icons.delete,
                                      borderRadius: customizedSlidAbleBorderRadius(context),
                                      label:
                                          LocalizationService
                                              .instance
                                              .tr
                                              .delete,
                                    ),
                                    SlidableAction(
                                      onPressed: (_) {
                                        Navigator.pushNamed(
                                          context,
                                          UpdateTransactionScreen.routeName,
                                          arguments: transaction,
                                        );
                                      },
                                      backgroundColor: AppColors.blue,
                                      foregroundColor: AppColors.white,
                                      icon: Icons.edit,
                                      label:
                                          LocalizationService.instance.tr.edit,
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onLongPress: () {
                                    showDescriptionDialog(
                                      context,
                                      transaction.note,
                                    );
                                  },
                                  child: CustomizedTransactionCard(
                                    transaction: transaction,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return const SizedBox(height: 10);
                            },
                          ),
                ),
              ],
            );
          }
          if (state is TransactionError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
