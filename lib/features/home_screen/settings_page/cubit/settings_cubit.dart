import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/features/home_screen/settings_page/cubit/delete_state.dart';

import '../../../../domain/use_cases/delete_all_trasnactions_usecase.dart';

class SettingsCubit extends Cubit<DeleteAllState> {
  static SettingsCubit get(context) => BlocProvider.of(context);
  final DeleteAllTransactionsUseCase deleteAllTransactionsUseCase;

  SettingsCubit({required this.deleteAllTransactionsUseCase})
    : super(DeleteInitialState());

  Future<void> deleteAllTransactions() async {
    try {
      emit(DeleteLoadingState());
      await deleteAllTransactionsUseCase.call();
      emit(DeleteSuccessState());
    } catch (e) {
      emit(DeleteFailureState());
    }
  }
}
