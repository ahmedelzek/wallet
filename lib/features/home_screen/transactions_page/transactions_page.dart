import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/features/home_screen/transactions_page/cubit/transactions_cubit.dart';
import 'package:wallet/features/home_screen/transactions_page/cubit/transactions_state.dart';

import '../../../core/app_router/app_router_keys.dart';
import '../../../core/customized_widgets/customized_slidable.dart';
import '../../../core/customized_widgets/customized_transaction_card.dart';
import '../../../core/di/injector.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_fonts.dart';
import '../../../core/resources/app_sizes.dart';
import '../../../l10n/app_translations.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (context) => sl<TransactionsCubit>()..getAllTransactions(),
      child: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
          final cubit = TransactionsCubit.get(context);
          if (state is TransactionsSuccessState) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await context.push(AppRouterKeys.addTransaction);
                  cubit.getAllTransactions();
                },
                backgroundColor: AppColors.green,
                child: Icon(Icons.add, color: AppColors.white, size: AppSize.s32),
              ),
              body: Padding(
                padding: EdgeInsets.all(AppPadding.p20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      onChanged: (value){
                        cubit.searchTransaction(value);
                      },
                      decoration: InputDecoration(
                        hintText: tr.search,
                        hintStyle: const TextStyle(color: AppColors.green),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                    SizedBox(height: AppHeight.h20),
                    Expanded(
                      child:
                          cubit.transactions.isEmpty
                              ? Center(
                                child: Text(
                                  tr.noTransactionsFound,
                                  style:  TextStyle(
                                    color: AppColors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.s20,
                                  ),
                                ),
                              )
                              : ListView.separated(
                                itemCount: cubit.transactions.length,
                                separatorBuilder:
                                    (_, __) =>  SizedBox(height: AppHeight.h10),
                                itemBuilder: (context, index) {
                                  final transaction = cubit.transactions[index];
                                  return CustomizedSlidAble(
                                    secondFunction: () async {
                                      await context.push(
                                        AppRouterKeys.editTransaction,
                                        extra: transaction,
                                      );
                                      cubit.getAllTransactions();
                                    },
                                    child: CustomizedTransactionCard(
                                      transaction: transaction,
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is TransactionsLoadingState) {
            return Scaffold(
              body: CircularProgressIndicator(color: AppColors.green),
            );
          }
          if (state is TransactionsErrorState) {
            return Scaffold(body: Center(child: Text(state.error)));
          }
          return SizedBox();
        },
      ),
    );
  }
}
