import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/domain/use_cases/update_transaction_usecase.dart';
import 'package:wallet/features/update_transaction_screen/cubit/update_transaction_state.dart';

import '../../../../domain/entities/transactions_entities.dart';
import '../../../core/resources/transaction_types.dart';

class UpdateTransactionCubit extends Cubit<UpdateTransactionState> {
  final UpdateTransactionUseCase updateTransactionUseCase;

  UpdateTransactionCubit(this.updateTransactionUseCase)
      : super(UpdateInitial());

  static UpdateTransactionCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  late int id;

  TransactionType? selectedType;


  void initialize(TransactionEntity transaction) {
    id = transaction.id;
    titleController.text = transaction.title;
    amountController.text = transaction.amount.toString();
    noteController.text = transaction.note?? "";
    selectedType = TransactionTypeExtension.fromKey(transaction.type);
  }

  Future<void> update() async {
    emit(UpdateLoading());
    try {
      if (formKey.currentState?.validate() == false) return;
      final transaction = TransactionEntity(
        id: id,
        title: titleController.text,
        amount: double.tryParse(amountController.text) ?? 0.0,
        note: noteController.text.isEmpty ? null : noteController.text,
        type: selectedType!.key,
      );

      await updateTransactionUseCase(transaction);
      emit(UpdateSuccess());
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }
}