import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wallet/core/customized_widgets/customized_transaction_card.dart';
import 'package:wallet/core/customized_widgets/description_show_dialog.dart';
import 'package:wallet/core/resources/app_colors.dart';

import '../../../core/customized_widgets/customized_slidable_border_radius.dart';
import '../../../core/di/injector.dart';
import '../../../l10n/app_translations.dart';
import '../../update_transaction_screen/update_transaction_screen.dart';
import 'cubit/transaction_cubit.dart';
import 'cubit/transaction_state.dart';
import 'home_page_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocProvider(
        create: (context)=>sl<HomeCubit>()..loadTransactions(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeSuccessState) {
              final income = state.incomeSum.toStringAsFixed(2);
              final outgoing = state.outgoingSum.toStringAsFixed(2);
              final balance = state.netBalance.toStringAsFixed(2);
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.darkGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 250,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr.currentBalance,
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
                        SizedBox(height: 20),
                        Row(
                          children: [
                            balanceCard(
                              tr.savings,
                              income,
                              Icons.energy_savings_leaf_sharp,
                              AppColors.blue,
                            ),
                            const SizedBox(width: 20),
                            balanceCard(
                              tr.debtPaid,
                              outgoing,
                              Icons.arrow_upward,
                              AppColors.orange,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                        state.transactions.isEmpty
                            ? Center(
                              child: Text(
                                tr.noTransactionsFound,
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
                                              .read<HomeCubit>()
                                              .deleteTransaction(transaction.id);
                                        },
                                        backgroundColor: AppColors.red,
                                        foregroundColor: AppColors.white,
                                        icon: Icons.delete,
                                        borderRadius:
                                            customizedSlidAbleBorderRadius(
                                              context,
                                            ),
                                        label: tr.delete,
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
                                        label: tr.edit,
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
            if (state is HomeErrorState) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
