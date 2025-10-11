import 'package:hive/hive.dart';
import '../../domain/entities/transactions_entities.dart';
import '../../domain/repos/transactions_repository.dart';
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
  Future<List<TransactionEntity>> getAllTransactions() async {
    final models = _box.values.toList();
    return models.map((e) => e.toEntity()).toList();
  }
}
