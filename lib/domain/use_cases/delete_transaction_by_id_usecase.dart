import 'package:wallet/domain/repos/transactions_repository.dart';

class DeleteTransactionByIdUseCase {
  final TransactionRepository repository;

  DeleteTransactionByIdUseCase(this.repository);

  Future<void> call(int id) async {
    await repository.deleteTransaction(id);
  }
}