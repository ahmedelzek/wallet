import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/domain/repos/transactions_repository.dart';

class SearchTransactionUseCase {
  final TransactionRepository repository;

  SearchTransactionUseCase(this.repository);
  Future<List<TransactionEntity>> call(String query) async {
    return repository.searchTransactions(query);
  }
}