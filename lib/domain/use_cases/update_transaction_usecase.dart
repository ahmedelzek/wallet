import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/domain/repos/transactions_repository.dart';

class UpdateTransactionUseCase{
  final TransactionRepository repository ;
  UpdateTransactionUseCase({required this.repository});

  Future<void> call(TransactionEntity transaction) async{
    await repository.addOrUpdateTransaction(transaction);
  }
}