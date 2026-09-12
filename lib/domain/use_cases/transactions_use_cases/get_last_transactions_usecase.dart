import '../../entities/transactions_entities.dart';
import '../../repos/transactions_repository.dart';

class GetLastTransactionsUseCase {
  final TransactionRepository repository;

  GetLastTransactionsUseCase({required this.repository});

  Future<List<TransactionEntity>> call() async {
    return await repository.getLastFiveTransactions();
  }
}
