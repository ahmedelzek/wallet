import '../../../../domain/entities/transactions_entities.dart';

abstract class DebtsState {}

class DebtsInitial extends DebtsState {}

class DebtsLoading extends DebtsState {}

class DebtsLoaded extends DebtsState {
  final List<TransactionEntity> transactions;

  DebtsLoaded(
      this.transactions,
      );
}

class DebtsError extends DebtsState {
  final String message;

  DebtsError(this.message);
}