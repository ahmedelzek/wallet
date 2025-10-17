import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_cases/get_income_sum_usecase.dart';
import '../../../../domain/use_cases/get_net_balance_usecase.dart';
import '../../../../domain/use_cases/get_outgoing_sum_usecase.dart';
import '../../../../domain/use_cases/get_transactions_usecase.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  final GetIncomeSumUseCase getIncomeSumUseCase;
  final GetOutgoingSumUseCase getOutgoingSumUseCase;
  final GetNetBalanceUseCase getNetBalanceUseCase;

  TransactionCubit(
    this.getTransactionsUseCase,
    this.getIncomeSumUseCase,
    this.getOutgoingSumUseCase,
    this.getNetBalanceUseCase,
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
}
