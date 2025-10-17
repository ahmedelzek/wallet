import '../repos/transactions_repository.dart';

class GetNetBalanceUseCase {
  final TransactionRepository repository;

  GetNetBalanceUseCase(this.repository);

  Future<double> call() async {
    return await repository.getNetBalance();
  }
}