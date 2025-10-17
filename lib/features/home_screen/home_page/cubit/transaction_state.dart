import '../../../../domain/entities/transactions_entities.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<TransactionEntity> transactions;
  final double incomeSum;
  final double outgoingSum;
  final double netBalance;

  TransactionLoaded(
    this.transactions,
    this.incomeSum,
    this.outgoingSum,
    this.netBalance,
  );
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}
