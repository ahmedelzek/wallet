import '../entities/transactions_entities.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionEntity transaction);
  Future<void> updateTransaction(TransactionEntity transaction);
  Future<List<TransactionEntity>> getAllTransactions();
  Future<void> deleteTransaction(int id);
  Future<void> deleteAllTransactions();
  Future<List<TransactionEntity>> searchTransactions(String query);
  Future<List<TransactionEntity>> getTransactionsByType(String type);
  Future<List<TransactionEntity>> getLastFiveTransactions();
  Future<double> getIncomeSum();
  Future<double> getOutgoingSum();
  Future<double> getSavingsSum();
  Future<double> getDebtsSum();
  Future<double> getNetBalance();
}
