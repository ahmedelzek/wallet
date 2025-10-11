import '../entities/transactions_entities.dart';
import '../repos/transactions_repository.dart';

class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  Future<void> call(TransactionEntity transaction) async {
    await repository.addTransaction(transaction);
  }
}
