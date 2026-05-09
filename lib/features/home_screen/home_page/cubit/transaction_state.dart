import '../../../../domain/entities/transactions_entities.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<TransactionEntity> transactions;
  final double incomeSum;
  final double outgoingSum;
  final double netBalance;

  HomeSuccessState(
    this.transactions,
    this.incomeSum,
    this.outgoingSum,
    this.netBalance,
  );
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
