import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/domain/use_cases/transactions_use_cases/get_debts_sum_use_case.dart';

import '../../../../domain/use_cases/transactions_use_cases/delete_transaction_by_id_usecase.dart';
import '../../../../domain/use_cases/transactions_use_cases/get_income_sum_usecase.dart';
import '../../../../domain/use_cases/transactions_use_cases/get_last_transactions_usecase.dart';
import '../../../../domain/use_cases/transactions_use_cases/get_net_balance_usecase.dart';
import '../../../../domain/use_cases/transactions_use_cases/get_outgoing_sum_usecase.dart';
import '../../../../domain/use_cases/transactions_use_cases/get_saving_sum_use_case.dart';
import '../../../../domain/use_cases/transactions_use_cases/search_transaction_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(context) => BlocProvider.of(context);
  final GetLastTransactionsUseCase getLastTransactionsUseCase;
  final SearchTransactionUseCase searchTransactionsUseCase;
  final GetIncomeSumUseCase getIncomeSumUseCase;
  final GetOutgoingSumUseCase getOutgoingSumUseCase;
  final GetSavingSumUseCase getSavingSumUseCase;
  final GetDebtsSumUseCase getDebtsSumUseCase;
  final GetNetBalanceUseCase getNetBalanceUseCase;
  final DeleteTransactionByIdUseCase deleteTransactionByIdUseCase;

  HomeCubit(
    this.getLastTransactionsUseCase,
    this.searchTransactionsUseCase,
    this.getIncomeSumUseCase,
    this.getOutgoingSumUseCase,
    this.getSavingSumUseCase,
    this.getDebtsSumUseCase,
    this.getNetBalanceUseCase,
    this.deleteTransactionByIdUseCase,
  ) : super(HomeInitialState());

  double incomeSum = 0;
  double outgoingSum = 0;
  double debtsSum = 0;
  double savingSum = 0;
  double netBalance = 0;
  List<TransactionEntity> transactions = [];

  Future<void> loadTransactions() async {
    emit(HomeLoadingState());
    try {
      transactions = await getLastTransactionsUseCase();
      incomeSum = await getIncomeSumUseCase();
      outgoingSum = await getOutgoingSumUseCase();
      debtsSum = await getDebtsSumUseCase();
      savingSum = await getSavingSumUseCase();
      netBalance = await getNetBalanceUseCase();

      emit(HomeSuccessState());
    } catch (e) {
      emit(HomeErrorState("Failed to load transactions: $e"));
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
        await deleteTransactionByIdUseCase(id);
        loadTransactions();
    } catch (e) {
      emit(HomeErrorState("Failed to delete transaction: $e"));
    }
  }

  Future<void> searchTransactions(String query) async {
    emit(HomeLoadingState());
    try {
      emit(HomeSuccessState());
    } catch (e) {
      emit(HomeErrorState("Failed to search transactions: $e"));
    }
  }
}
