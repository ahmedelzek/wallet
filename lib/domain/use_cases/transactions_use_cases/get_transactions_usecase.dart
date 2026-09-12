import '../../entities/transactions_entities.dart';
import '../../repos/transactions_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase({required this.repository});

  Future<List<TransactionEntity>> call() async {
    return await repository.getAllTransactions();
  }
}
