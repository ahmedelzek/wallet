import 'package:hive/hive.dart';
import 'package:wallet/core/resources/transaction_types.dart';

import '../../domain/entities/transactions_entities.dart';
import '../../domain/repos/transactions_repository.dart';
import '../models/transactions/transactions_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final Box<TransactionModel> box;

  TransactionRepositoryImpl({required this.box});

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    await box.put(model.id, model);
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    await box.put(model.id, model);
  }

  @override
  Future<void> deleteAllTransactions() async {
    await box.clear();
  }

  @override
  Future<void> deleteTransaction(int id) async {
    await box.delete(id);
  }

  @override
  Future<List<TransactionEntity>> searchTransactions(String query) async {
    final models =
        box.values
            .where(
              (tx) =>
                  tx.title.toLowerCase().contains(query.toLowerCase()) ||
                  tx.type.toLowerCase().contains(query.toLowerCase()) ||
                  (tx.note?.toLowerCase().contains(query.toLowerCase()) ??
                      false),
            )
            .toList();

    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<TransactionEntity>> getAllTransactions() async {
    final models = box.values.toList();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<TransactionEntity>> getLastFiveTransactions() async {
    final lastFiveTransactions = box.values.toList().reversed.take(5);
    return lastFiveTransactions.map((e)=> e.toEntity()).toList();
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByType(String type) async {
    final all = box.values.toList();

    final filtered = all.where((tx) => tx.type.toLowerCase() == type.toLowerCase()).toList();

    return filtered.map((e) => e.toEntity()).toList();
  }

  Future<double> _getSumOfType(String type) async {
    final transactions = await getAllTransactions();
    return transactions
        .where((tx) => tx.type.toLowerCase() == type.toLowerCase())
        .fold<double>(0.0, (sum, tx) => sum + tx.amount);
  }

  @override
  Future<double> getIncomeSum() =>
      _getSumOfType(TransactionType.income.key);

  @override
  Future<double> getOutgoingSum() =>
      _getSumOfType(TransactionType.outgoing.key);

  @override
  Future<double> getSavingsSum() => _getSumOfType(TransactionType.savings.key);

  @override
  Future<double> getDebtsSum() =>
      _getSumOfType(TransactionType.debts.key);

  @override
  Future<double> getNetBalance() async {
    final income = await getIncomeSum();
    final outgoing = await getOutgoingSum();
    return income - outgoing;
  }
}
