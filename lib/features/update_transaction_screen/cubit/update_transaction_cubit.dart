import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/features/update_transaction_screen/cubit/update_transaction_state.dart';
import '../../../domain/use_cases/update_transaction_usecase.dart';

class UpdateTransactionCubit extends Cubit<UpdateTransactionState> {
  final UpdateTransactionUseCase updateTransactionUseCase;

  UpdateTransactionCubit(this.updateTransactionUseCase) : super(UpdateInitial());

  Future<void> updateTransaction(TransactionEntity transaction) async {
    emit(UpdateLoading());
    try {
      await updateTransactionUseCase.call(transaction);
      emit(UpdateSuccess());
    } catch (e) {
      emit(UpdateError("Failed to load transactions: $e"));
    }
  }
}