import '../repos/transactions_repository.dart';

class GetIncomeSumUseCase{
  final TransactionRepository repository;

  GetIncomeSumUseCase({required this.repository});

  Future<double> call () async {
    return await repository.getIncomeSum();
  }
}