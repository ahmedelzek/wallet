import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/domain/repos/transactions_repository.dart';

class GetTransactionsByTypeUseCase {
  final TransactionRepository repository;

  GetTransactionsByTypeUseCase({required this.repository});

  Future<List<TransactionEntity>> call(String type) async {
    return repository.getTransactionsByType(type);
  }
}