import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wallet/features/home_screen/home_page/cubit/transaction_cubit.dart';
import 'package:wallet/features/home_screen/home_page/cubit/transaction_state.dart';

import '../../../core/customized_widgets/customized_slidable_border_radius.dart';
import '../../../core/customized_widgets/customized_transaction_card.dart';
import '../../../core/customized_widgets/description_show_dialog.dart';
import '../../../core/resources/app_colors.dart';
import '../../../l10n/app_translations.dart';
import '../../update_transaction_screen/update_transaction_screen.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      context.read<TransactionCubit>().searchTransactions(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (BuildContext context, state) {
          if (state is TransactionLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.green),
            );
          }

          if (state is TransactionLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: LocalizationService.instance.tr.search,
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
                            separatorBuilder:
                                (_, __) => const SizedBox(height: 10),
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
