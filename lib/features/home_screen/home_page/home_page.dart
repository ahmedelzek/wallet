import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wallet/core/customized_widgets/customized_transaction_card.dart';
import 'package:wallet/core/customized_widgets/description_show_dialog.dart';
import 'package:wallet/core/resources/app_colors.dart';

import '../../../core/customized_widgets/customized_slidable_border_radius.dart';
import '../../../core/di/injector.dart';
import '../../../l10n/app_translations.dart';
import '../../update_transaction_screen/update_transaction_screen.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'home_page_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (context)=>sl<HomeCubit>()..loadTransactions(),
        child: Padding(
          padding:  EdgeInsets.all(20.sp),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final cubit = HomeCubit.get(context);
              if (state is HomeLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              else if (state is HomeErrorState) {
                return Center(child: Text(state.message));
              }
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.darkGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 250.h,
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
                          "${cubit.netBalance} EGP",
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
                              tr.income,
                              cubit.incomeSum.toString(),
                              Icons.arrow_downward,
                              AppColors.green,
                            ),
                            const SizedBox(width: 20),
                            balanceCard(
                              tr.outgoing,
                              cubit.outgoingSum.toString(),
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
                              cubit.incomeSum.toString(),
                              Icons.energy_savings_leaf_sharp,
                              AppColors.blue,
                            ),
                            const SizedBox(width: 20),
                            balanceCard(
                              tr.debtPaid,
                              cubit.outgoingSum.toString(),
                              Icons.arrow_upward,
                              AppColors.orange,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Expanded(
                    child:
                    cubit.transactions.isEmpty
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
                      itemCount: cubit.transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = cubit.transactions[index];
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
            },
          ),
        ),);
  }
}
