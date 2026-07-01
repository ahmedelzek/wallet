import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/domain/use_cases/delete_transaction_by_id_usecase.dart';

import '../../../../domain/use_cases/get_income_sum_usecase.dart';
import '../../../../domain/use_cases/get_net_balance_usecase.dart';
import '../../../../domain/use_cases/get_outgoing_sum_usecase.dart';
import '../../../../domain/use_cases/get_transactions_usecase.dart';
import '../../../../domain/use_cases/search_transaction_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  static HomeCubit get(context)=>BlocProvider.of(context);
  final GetTransactionsUseCase getTransactionsUseCase;
  final SearchTransactionUseCase searchTransactionsUseCase;
  final GetIncomeSumUseCase getIncomeSumUseCase;
  final GetOutgoingSumUseCase getOutgoingSumUseCase;
  final GetNetBalanceUseCase getNetBalanceUseCase;
  final DeleteTransactionByIdUseCase deleteTransactionByIdUseCase;

  HomeCubit(
    this.getTransactionsUseCase,
    this.searchTransactionsUseCase,
    this.getIncomeSumUseCase,
    this.getOutgoingSumUseCase,
    this.getNetBalanceUseCase,
    this.deleteTransactionByIdUseCase,
  ) : super(HomeInitialState());

  double incomeSum = 0;
  double outgoingSum = 0;
  double netBalance = 0;
  List<TransactionEntity> transactions = [];

  Future<void> loadTransactions() async {
    emit(HomeLoadingState());
    try {
      transactions = await getTransactionsUseCase();
      incomeSum = await getIncomeSumUseCase();
      outgoingSum = await getOutgoingSumUseCase();
      netBalance = await getNetBalanceUseCase();

      emit(HomeSuccessState());
    } catch (e) {
      emit(HomeErrorState("Failed to load transactions: $e"));
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      if (state is HomeSuccessState) {
        await deleteTransactionByIdUseCase(id);
        loadTransactions();
      }
    } catch (e) {
      emit(HomeErrorState("Failed to delete transaction: $e"));
    }
  }

  Future<void> searchTransactions(String query) async {
    emit(HomeLoadingState());
    try {
      final results = await searchTransactionsUseCase(query);
      final incomeSum = await getIncomeSumUseCase();
      final outgoingSum = await getOutgoingSumUseCase();
      final netBalance = await getNetBalanceUseCase();

      emit(HomeSuccessState());
    } catch (e) {
      emit(HomeErrorState("Failed to search transactions: $e"));
    }
  }
}
