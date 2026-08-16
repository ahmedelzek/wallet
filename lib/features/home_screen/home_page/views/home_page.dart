import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/core/customized_widgets/customized_slidable.dart';
import 'package:wallet/core/customized_widgets/customized_transaction_card.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/resources/app_sizes.dart';

import '../../../../core/app_router/app_router_keys.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/resources/app_fonts.dart';
import '../../../../l10n/app_translations.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'home_page_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..loadTransactions(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeErrorState) {
            return Center(child: Text(state.message));
          }
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await context.push(AppRouterKeys.addTransaction);
                cubit.loadTransactions();
              },
              backgroundColor: AppColors.green,
              child: Icon(Icons.add, color: AppColors.white, size: AppSize.s32),
            ),
            body: Padding(
              padding: EdgeInsets.all(AppPadding.p20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppPadding.p16),
                    decoration: BoxDecoration(
                      color: AppColors.darkGreen,
                      borderRadius: BorderRadius.circular(AppPadding.p20),
                    ),
                    height: AppHeight.h250,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr.currentBalance,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.s18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${cubit.netBalance} EGP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.s18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: AppHeight.h20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            balanceCard(
                              tr.income,
                              cubit.incomeSum.toString(),
                              Icons.arrow_downward,
                              AppColors.green,
                            ),
                            SizedBox(width: AppWidth.w20),
                            balanceCard(
                              tr.outgoing,
                              cubit.outgoingSum.toString(),
                              Icons.arrow_upward,
                              AppColors.red,
                            ),
                          ],
                        ),
                        SizedBox(height: AppHeight.h20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            balanceCard(
                              tr.savings,
                              cubit.savingSum.toString(),
                              Icons.energy_savings_leaf_sharp,
                              AppColors.blue,
                            ),
                            SizedBox(width: AppWidth.w20),
                            balanceCard(
                              tr.debtPaid,
                              cubit.debtsSum.toString(),
                              Icons.arrow_upward,
                              AppColors.orange,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppHeight.h20),
                  Expanded(
                    child:
                        cubit.transactions.isEmpty
                            ? Center(
                              child: Text(
                                tr.noTransactionsFound,
                                style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontSize.s20,
                                ),
                              ),
                            )
                            : ListView.separated(
                              itemCount: cubit.transactions.length,
                              itemBuilder: (context, index) {
                                final transaction = cubit.transactions[index];
                                return CustomizedSlidAble(
                                  firstFunction:
                                      ()async => await cubit.deleteTransaction(
                                        transaction.id,
                                      ),
                                  secondFunction: () async {
                                    await context.push(
                                      AppRouterKeys.editTransaction,
                                      extra: transaction,
                                    );
                                    await cubit.loadTransactions();
                                  },
                                  child: CustomizedTransactionCard(
                                    transaction: transaction,
                                  ),
                                );
                              },
                              separatorBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return SizedBox(height: AppHeight.h10);
                              },
                            ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
