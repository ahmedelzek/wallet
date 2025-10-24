import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/core/customized_widgets/customized_transaction_card.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/features/home_screen/debts_page/cubit/debts_state.dart';
import 'package:wallet/l10n/app_translations.dart';

import 'cubit/debts_cubit.dart';

class AllDebtsViewPage extends StatefulWidget {
  const AllDebtsViewPage({super.key});

  @override
  State<AllDebtsViewPage> createState() => _AllDebtsViewPageState();
}

class _AllDebtsViewPageState extends State<AllDebtsViewPage> {
  @override
  void initState() {
    super.initState();
    context.read<DebtsCubit>().getTransactionsByType('debts');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<DebtsCubit, DebtsState>(
        builder: (context, state) {
          if (state is DebtsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            );
          }

          if (state is DebtsLoaded) {
            final transactions = state.transactions;

            if (transactions.isEmpty) {
              return Center(
                child: Text(
                  LocalizationService.instance.tr.noDebtsFound,
                  style: const TextStyle(
                    color: AppColors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return ListView.separated(
              itemCount: transactions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return CustomizedTransactionCard(transaction: tx);
              },
            );
          }

          if (state is DebtsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
