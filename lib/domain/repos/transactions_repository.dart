import '../entities/transactions_entities.dart';

abstract class TransactionRepository {
  Future<void> addOrUpdateTransaction(TransactionEntity transaction);
  Future<List<TransactionEntity>> getAllTransactions();
  Future<void> deleteTransaction(int id);
  Future<void> deleteAllTransactions();
  Future<List<TransactionEntity>> searchTransactions(String query);
  Future<double> getIncomeSum();
  Future<double> getOutgoingSum();
  Future<double> getSavingsSum();
  Future<double> getDebtPendingSum();
  Future<double> getDebtPaidSum();
  Future<double> getNetBalance();
}
