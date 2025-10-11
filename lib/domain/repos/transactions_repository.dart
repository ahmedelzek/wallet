import '../entities/transactions_entities.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionEntity transaction);
  Future<List<TransactionEntity>> getAllTransactions();
}
