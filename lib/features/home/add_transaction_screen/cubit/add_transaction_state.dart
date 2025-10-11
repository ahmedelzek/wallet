abstract class AddTransactionState {}

class AddTransactionInitial extends AddTransactionState {}

class AddTransactionLoading extends AddTransactionState {}

class AddTransactionSuccess extends AddTransactionState {}

class AddTransactionFailure extends AddTransactionState {
  final String message;
  AddTransactionFailure(this.message);
}
