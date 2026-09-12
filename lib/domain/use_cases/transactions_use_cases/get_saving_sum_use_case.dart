import '../../repos/transactions_repository.dart';

class GetSavingSumUseCase {
  final TransactionRepository repository;

  GetSavingSumUseCase({required this.repository});

  Future<double> call() async {
    return await repository.getSavingsSum();
  }
}