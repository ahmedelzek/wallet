import '../repos/transactions_repository.dart';

class GetOutgoingSumUseCase {
  final TransactionRepository repository;

  GetOutgoingSumUseCase({required this.repository});

  Future<double> call() async {
    return await repository.getOutgoingSum();
  }
}