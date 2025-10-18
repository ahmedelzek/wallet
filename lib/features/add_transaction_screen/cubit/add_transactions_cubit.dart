import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/transactions_entities.dart';
import '../../../../domain/use_cases/add_transaction_usecase.dart';
import 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  final AddTransactionUseCase addTransactionUseCase;

  AddTransactionCubit(this.addTransactionUseCase)
      : super(AddTransactionInitial());

  Future<void> addTransaction(TransactionEntity transaction) async {
    emit(AddTransactionLoading());
    try {
      await addTransactionUseCase(transaction);
      emit(AddTransactionSuccess());
    } catch (e) {
      emit(AddTransactionFailure(e.toString()));
    }
  }
}