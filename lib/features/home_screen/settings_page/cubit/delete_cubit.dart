import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/use_cases/delete_all_trasnactions_usecase.dart';
import 'delete_state.dart';

class DeleteAllCubit extends Cubit<DeleteAllState> {
  final DeleteAllTransactionsUseCase deleteAllTransactionsUseCase;

  DeleteAllCubit(this.deleteAllTransactionsUseCase) : super(DeleteLoading());

  Future<void> deleteAllTransactions() async {
    try {
      emit(DeleteLoading());
      await deleteAllTransactionsUseCase.call();
      emit(DeleteSuccess());
    } catch (e) {
      emit(DeleteFailure());
    }
  }
}
