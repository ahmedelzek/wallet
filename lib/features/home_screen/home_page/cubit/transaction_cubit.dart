import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/domain/use_cases/delete_transaction_by_id_usecase.dart';

import '../../../../domain/use_cases/get_income_sum_usecase.dart';
import '../../../../domain/use_cases/get_net_balance_usecase.dart';
import '../../../../domain/use_cases/get_outgoing_sum_usecase.dart';
import '../../../../domain/use_cases/get_transactions_usecase.dart';
import '../../../../domain/use_cases/search_transaction_usecase.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  final SearchTransactionUseCase searchTransactionsUseCase;
  final GetIncomeSumUseCase getIncomeSumUseCase;
  final GetOutgoingSumUseCase getOutgoingSumUseCase;
  final GetNetBalanceUseCase getNetBalanceUseCase;
  final DeleteTransactionByIdUseCase deleteTransactionByIdUseCase;

  TransactionCubit(
    this.getTransactionsUseCase,
    this.searchTransactionsUseCase,
    this.getIncomeSumUseCase,
    this.getOutgoingSumUseCase,
    this.getNetBalanceUseCase,
    this.deleteTransactionByIdUseCase,
  ) : super(TransactionInitial());

  Future<void> loadTransactions() async {
    emit(TransactionLoading());
    try {
      final transactions = await getTransactionsUseCase();
      final incomeSum = await getIncomeSumUseCase();
      final outgoingSum = await getOutgoingSumUseCase();
      final netBalance = await getNetBalanceUseCase();

      emit(TransactionLoaded(transactions, incomeSum, outgoingSum, netBalance));
    } catch (e) {
      emit(TransactionError("Failed to load transactions: $e"));
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      if (state is TransactionLoaded) {
        await deleteTransactionByIdUseCase(id);
        loadTransactions();
      }
    } catch (e) {
      emit(TransactionError("Failed to delete transaction: $e"));
    }
  }

  Future<void> searchTransactions(String query) async {
    emit(TransactionLoading());
    try {
      final results = await searchTransactionsUseCase(query);
      final incomeSum = await getIncomeSumUseCase();
      final outgoingSum = await getOutgoingSumUseCase();
      final netBalance = await getNetBalanceUseCase();

      emit(TransactionLoaded(results, incomeSum, outgoingSum, netBalance));
    } catch (e) {
      emit(TransactionError("Failed to search transactions: $e"));
    }
  }

}
