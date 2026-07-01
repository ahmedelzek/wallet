import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/features/home_screen/transactions_page/cubit/transactions_cubit.dart';
import 'package:wallet/features/home_screen/transactions_page/cubit/transactions_state.dart';

import '../../../core/app_router/app_router_keys.dart';
import '../../../core/customized_widgets/customized_slidable_border_radius.dart';
import '../../../core/customized_widgets/customized_transaction_card.dart';
import '../../../core/customized_widgets/description_show_dialog.dart';
import '../../../core/di/injector.dart';
import '../../../core/resources/app_colors.dart';
import '../../../l10n/app_translations.dart';
import '../../update_transaction_screen/update_transaction_screen.dart';

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
                child: Icon(Icons.add, color: AppColors.white, size: 32),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: tr.search,
                        hintStyle: const TextStyle(color: AppColors.green),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                                separatorBuilder:
                                    (_, __) => const SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final transaction = cubit.transactions[index];
                                  return Slidable(
                                    startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      extentRatio: .4,
                                      children: [
                                        SlidableAction(
                                          onPressed: (_) {},
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
