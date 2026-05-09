import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/transactions_entities.dart';
import '../../../../domain/use_cases/add_transaction_usecase.dart';
import '../../../core/resources/transaction_types.dart';
import 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  final AddTransactionUseCase addTransactionUseCase;

  AddTransactionCubit(this.addTransactionUseCase)
    : super(AddTransactionInitial());

  static AddTransactionCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  TransactionType? selectedType;


  Future<void> addTransaction() async {
    emit(AddTransactionLoading());
    try {
      if (formKey.currentState?.validate() == false) return;
      final transaction = TransactionEntity(
        id: DateTime.now().millisecondsSinceEpoch & 0xFFFFFFFF,
        title: titleController.text,
        amount: double.tryParse(amountController.text) ?? 0.0,
        note: noteController.text.isEmpty ? null : noteController.text,
        type: selectedType!.key,
      );

      await addTransactionUseCase(transaction);
      emit(AddTransactionSuccess());
    } catch (e) {
      emit(AddTransactionFailure(e.toString()));
    }
  }
}