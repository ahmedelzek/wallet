import 'package:hive/hive.dart';
import 'package:wallet/core/resources/transaction_types.dart';

import '../../domain/entities/transactions_entities.dart';
import '../../domain/repos/transactions_repository.dart';
import '../../l10n/app_translations.dart';
import '../models/transactions_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final Box<TransactionModel> _box;

  TransactionRepositoryImpl(this._box);

  @override
  Future<void> addOrUpdateTransaction(TransactionEntity transaction) async {
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
  Future<List<TransactionEntity>> searchTransactions(String query) async {
    final models =
        _box.values
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
    final models = _box.values.toList();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByType(String type) async {
    final all = _box.values.toList();

    if (type.toLowerCase() == 'debts') {
      final filtered =
          all.where((tx) {
            final t = tx.type.toLowerCase();
            return t ==
                    LocalizationService.instance.tr.debtPaid.toLowerCase() ||
                t == LocalizationService.instance.tr.debtPending.toLowerCase();
          }).toList();

      return filtered.map((e) => e.toEntity()).toList();
    }

    final filtered =
        all.where((tx) => tx.type.toLowerCase() == type.toLowerCase()).toList();

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
  Future<double> getDebtPendingSum() =>
      _getSumOfType(TransactionType.debtPending.key);

  @override
  Future<double> getDebtPaidSum() =>
      _getSumOfType(TransactionType.debtPaid.key);

  @override
  Future<double> getNetBalance() async {
    final income = await getIncomeSum();
    final outgoing = await getOutgoingSum();
    return income - outgoing;
  }
}
