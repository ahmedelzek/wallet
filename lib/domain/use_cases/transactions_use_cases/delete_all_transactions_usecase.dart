import 'package:wallet/domain/repos/transactions_repository.dart';

class DeleteAllTransactionsUseCase {
  final TransactionRepository repository;

  DeleteAllTransactionsUseCase({required this.repository});

  Future<void> call() async {
    await repository.deleteAllTransactions();
  }
}
