import 'package:wallet/domain/repos/transactions_repository.dart';

class GetDebtsSumUseCase{
  final TransactionRepository repository;
  GetDebtsSumUseCase({required this.repository});

  Future<double> call() async => await repository.getDebtsSum();
}