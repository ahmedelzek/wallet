import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/domain/use_cases/get_transactions_usecase.dart';
import 'package:wallet/domain/use_cases/search_transaction_usecase.dart';
import 'package:wallet/features/home_screen/transactions_page/cubit/transactions_state.dart';

import '../../../../domain/entities/transactions_entities.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  static TransactionsCubit get(context) => BlocProvider.of(context);
  final GetTransactionsUseCase getTransactionsUseCase;
  final SearchTransactionUseCase searchTransactionUseCase;

  TransactionsCubit({
    required this.getTransactionsUseCase,
    required this.searchTransactionUseCase,
  }) : super(TransactionsInitialState());

  List<TransactionEntity> transactions = [];

  Future<void> getAllTransactions() async {
    emit(TransactionsLoadingState());
    try {
      transactions = await getTransactionsUseCase();

      emit(TransactionsSuccessState());
    } catch (e) {
      emit(TransactionsErrorState(error: "Failed to search transactions: $e"));
    }
  }

  Future<void> searchTransaction(String query) async {
    try {
      transactions = await searchTransactionUseCase(query);
      emit(TransactionsSuccessState());
    } catch (e) {
      emit(TransactionsErrorState(error: "Failed to search transactions: $e"));
    }
  }
}
