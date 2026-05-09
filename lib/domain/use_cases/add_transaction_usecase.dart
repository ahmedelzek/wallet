import '../entities/transactions_entities.dart';
import '../repos/transactions_repository.dart';

class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase({required this.repository});

  Future<void> call(TransactionEntity transaction) async {
    await repository.addOrUpdateTransaction(transaction);
  }
}
