import 'package:hive/hive.dart';

import '../../domain/entities/transactions_entities.dart';
import '../../domain/repos/transactions_repository.dart';
import '../../l10n/app_translations.dart';
import '../models/transactions_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final Box<TransactionModel> _box;

  TransactionRepositoryImpl(this._box);

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    await _box.put(model.id, model);
  }
  @override
  Future<void> deleteAllTransactions() async {
    await _box.clear();
  }

  @override
  Future<void> deleteTransaction(int id) async {
    await _box.delete(id);
  }

  @override
  Future<List<TransactionEntity>> getAllTransactions() async {
    final models = _box.values.toList();
    return models.map((e) => e.toEntity()).toList();
  }

  Future<double> _getSumOfType(String type) async {
    final transactions = await getAllTransactions();
    return transactions
        .where((tx) => tx.type.toLowerCase() == type.toLowerCase())
        .fold<double>(0.0, (sum, tx) => sum + tx.amount);
  }

  @override
  Future<double> getIncomeSum() =>
      _getSumOfType(LocalizationService.instance.tr.income);

  @override
  Future<double> getOutgoingSum() =>
      _getSumOfType(LocalizationService.instance.tr.outgoing);

  @override
  Future<double> getSavingsSum() =>
      _getSumOfType(LocalizationService.instance.tr.savings);

  @override
  Future<double> getDebtPendingSum() =>
      _getSumOfType(LocalizationService.instance.tr.debtPending);

  @override
  Future<double> getDebtPaidSum() =>
      _getSumOfType(LocalizationService.instance.tr.debtPaid);

  @override
  Future<double> getNetBalance() async {
    final income = await getIncomeSum();
    final outgoing = await getOutgoingSum();
    return income - outgoing;
  }
}
