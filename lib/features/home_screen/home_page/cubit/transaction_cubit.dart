import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/features/home_screen/home_page/cubit/transaction_state.dart';

import '../../../../domain/use_cases/get_transactions_usecase.dart';


class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;

  TransactionCubit(this.getTransactionsUseCase) : super(TransactionInitial());

  Future<void> loadTransactions() async {
    emit(TransactionLoading());
    try {
      final transactions = await getTransactionsUseCase();
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError("Failed to load transactions: $e"));
    }
  }
}
