import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/domain/use_cases/get_transactions_by_type_usecase.dart';

import 'debts_state.dart';

class DebtsCubit extends Cubit<DebtsState>{
  final GetTransactionsByTypeUseCase getTransactionsByTypeUseCase;

  DebtsCubit(this.getTransactionsByTypeUseCase) : super(DebtsInitial());

  Future<void> getTransactionsByType(String type) async {
    emit(DebtsLoading());
    try {
      final transactions = await getTransactionsByTypeUseCase(type);

      emit(DebtsLoaded(transactions));
    } catch (e) {
      emit(DebtsError("Failed to load debts transactions: $e"));
    }
  }
}